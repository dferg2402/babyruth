workspace "EventHub Ticketing" "C4 model of EventHub Ticketing version 1, revised after Call 3 (design call)." {

    model {
        buyer = person "Ticket Buyer" "Student, parent, or fan anywhere in the world. Registers, browses and searches events, buys tickets, and reopens past orders."
        administrator = person "Administrator" "EventHub staff (e.g. finance) with the administrator role. Updates exchange rates and reads the audit log to investigate disputes." {
            tags "Administrator"
        }

        eventhub = softwareSystem "EventHub Ticketing" "Public ticketing website with simulated payment, on-screen confirmation, and an administrator-only area for rates and the audit log. BOUNDARY RULE: all incoming data is validated; buyers can never act as administrators." {
            tags "EventHub"

            webapp = container "Web Application" "Serves every buyer and administrator page as server-rendered HTML. One deployable Flask application organised as blueprints; holds every business rule." "Python 3.12, Flask 3, Jinja2, SQLAlchemy 2, Gunicorn" {

                group "Request boundary" {
                    boundary = component "Request Boundary" "Validates every incoming value (form fields, quantities, currency codes, ids, return targets) against typed form schemas and checks the CSRF token before any component sees it. Rejects with a specific message." "Flask-WTF forms, before_request hook"
                    guard = component "Access Guard" "Loads the session and account role, enforces the idle timeout, redirects signed-out users to login with a safe relative return target, and lets /admin routes through only for the administrator role." "Flask-Login, @login_required, @admin_required"
                }

                group "Buyer-facing" {
                    identity = component "Identity" "Registration, login, logout, password hashing, USF-eligibility flag, account role, most recent currency." "auth blueprint, IdentityService"
                    catalog = component "Catalog" "Upcoming-event list, artist and venue search with the no-match fallback, event detail pages with tickets remaining." "catalog blueprint, CatalogService"
                    orders = component "Orders" "Saves orders with their price snapshot, renders the on-screen confirmation and the order history. Owner-only access." "orders blueprint, OrderRepository"
                }

                group "Purchase path" {
                    purchase = component "Purchase" "Runs checkout and quick buy in a fixed order: identity, catalog, pricing, inventory, audit. Stateless checkout with a one-time idempotency token; no order exists until the purchase commits." "checkout blueprint, PurchaseService"
                    pricing = component "Pricing" "The only place prices are computed: base price x quantity, USF discount, currency conversion, one rounding step. Pure functions over Money values (integer minor units + ISO 4217 code)." "PricingService, Money, decimal.Decimal"
                    inventory = component "Inventory" "Checks the per-account limit and decrements tickets remaining with one conditional UPDATE inside the purchase transaction, so overselling is impossible." "InventoryRepository, BEGIN IMMEDIATE transaction"
                    audit = component "Audit" "Single owner of the append-only audit trail: every purchase attempt (success or failure, with reason) and every administrator rate change." "AuditLogger"
                }

                group "Administrator-only" {
                    adminArea = component "Administration" "Exchange-rate editor and audit log viewer under /admin. Reachable only through the Access Guard with the administrator role; no buyer-facing component calls it." "admin blueprint, AdminService" {
                        tags "Administrator"
                    }
                }

                rates = component "Exchange Rate Store" "Reads and writes the supported currencies and their rates against USD (stored as exact decimal text). Read by Pricing, written only by Administration." "ExchangeRateRepository"
            }

            cli = container "Management CLI" "Setup and operations commands run on the server by EventHub engineers: create the schema, load events from the event data file, and grant the administrator role to an existing account." "Python, Flask CLI (click)"

            db = container "Database" "Accounts and roles, events and tickets remaining, orders with price snapshots, currencies and exchange rates, audit log." "SQLite 3 in WAL mode, accessed through SQLAlchemy" {
                tags "Database"
            }
        }

        # Context and container relationships (declared first so they are not duplicated by implied relationships)
        buyer -> webapp "Registers, browses and searches events, buys tickets, and views order history using" "HTTPS"
        administrator -> webapp "Updates exchange rates and reads the audit log using" "HTTPS"
        webapp -> db "Reads from and writes to" "SQLAlchemy, SQLite"
        cli -> db "Creates the schema, loads events, and grants the administrator role in" "SQLAlchemy, SQLite"

        # Component relationships: request handling
        buyer -> boundary "Sends every page request and form to" "HTTPS"
        administrator -> boundary "Sends administration requests to" "HTTPS"
        boundary -> guard "Passes validated requests to"
        guard -> identity "Routes sign-up and login to, and loads the signed-in account and role from"
        guard -> catalog "Routes event list, search, and event pages to"
        guard -> purchase "Routes checkout and quick buy (signed-in buyers only) to"
        guard -> orders "Routes confirmation and order history (signed-in owner only) to"
        guard -> adminArea "Routes /admin requests (administrator role only) to"

        # Component relationships: the purchase path, in order
        purchase -> identity "1. Gets the signed-in buyer and USF eligibility from"
        purchase -> catalog "2. Loads the upcoming event and base price from"
        purchase -> pricing "3. Requests a price quote from"
        purchase -> inventory "4. Checks the account limit and decrements tickets remaining (one transaction) via"
        purchase -> orders "4. Saves the order in the same transaction via"
        purchase -> audit "5. Records every attempt and its outcome via"
        pricing -> rates "Reads the current exchange rate from"

        # Component relationships: administration
        adminArea -> rates "Updates exchange rates in"
        adminArea -> audit "Records rate changes and queries audit entries via"

        # Component relationships: persistence
        identity -> db "Reads and writes accounts in" "SQL"
        catalog -> db "Reads events and tickets remaining from" "SQL"
        inventory -> db "Runs the conditional ticket decrement in" "SQL"
        orders -> db "Inserts and reads orders in" "SQL"
        audit -> db "Appends and queries audit entries in" "SQL"
        rates -> db "Reads and writes currencies and rates in" "SQL"
    }

    views {
        systemContext eventhub "context-view" "EventHub Ticketing: system context after Call 3 (two actors, no external systems)" {
            include *
            autoLayout lr
        }

        container eventhub "container-view" "EventHub Ticketing: containers" {
            include *
            autoLayout lr
        }

        component webapp "component-view" "Web Application: components, the purchase path, and the administrator-only area" {
            include *
            autoLayout lr
        }

        dynamic webapp "purchase-path" "Purchase path: one indivisible purchase, audited inside the path" {
            buyer -> boundary "Submits checkout form: event id, quantity, currency, one-time token"
            boundary -> guard "Passes the validated values"
            guard -> purchase "Forwards the request of a signed-in buyer"
            purchase -> identity "Gets buyer id and USF eligibility"
            purchase -> catalog "Loads the upcoming event and its base price"
            purchase -> pricing "Requests a quote for event, quantity, currency, buyer"
            pricing -> rates "Reads the rate for the currency"
            purchase -> inventory "BEGIN IMMEDIATE; per-account limit check; conditional decrement"
            inventory -> db "Conditional UPDATE: decrement only if tickets_remaining >= q"
            purchase -> orders "Inserts the order with its price snapshot (same transaction)"
            purchase -> audit "Appends the attempt and outcome (same transaction on success, own transaction on failure)"
            audit -> db "INSERT audit entry, then COMMIT"
            autoLayout lr
        }

        styles {
            element "Element" {
                color #ffffff
            }
            element "Person" {
                shape Person
                background #08427b
            }
            element "Administrator" {
                background #8e2a1f
                color #ffffff
            }
            element "Software System" {
                background #1168bd
            }
            element "Container" {
                background #438dd5
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Database" {
                shape Cylinder
            }
        }
    }
}
