workspace "EventHub Ticketing (original, Calls 1-2)" "First container and component design, generated with GenAI from the Part 2 context diagram and the Call 1 and Call 2 decisions only, before Call 3." {

    model {
        buyer = person "Ticket Buyer" "Student, parent, or fan anywhere in the world. The only user role in version 1."

        eventhub = softwareSystem "EventHub Ticketing" "Python/Flask web app for registration, browsing, and ticket purchase (simulated payment, on-screen confirmation). Event data, exchange-rate config, and audit log live inside. BOUNDARY RULE: all incoming data is validated here." {
            tags "EventHub"

            webapp = container "Web Application" "Server-rendered website for registration, browsing, search, checkout, confirmation, and order history." "Python, Flask, Jinja2, SQLAlchemy" {
                auth = component "Auth" "Registration, login, logout, password hashing, sessions with idle expiry, USF email flag; login_required decorator for checkout and order history." "auth blueprint"
                catalog = component "Catalog" "Upcoming-event list, search by artist and venue, event detail page with tickets remaining." "catalog blueprint"
                checkout = component "Checkout" "Validates quantity and currency, applies the USF discount, converts the total with the configured rate, checks availability, decrements tickets, and creates the order in a database transaction." "checkout blueprint"
                rateLoader = component "Rate Loader" "Reads the exchange-rate file at application start and keeps the rates in an in-memory dictionary." "Python module"
                orders = component "Order History" "On-screen confirmation page and order history for the signed-in user." "orders blueprint"
                auditLogger = component "Audit Logger" "Helper that checkout routes call to write each purchase attempt and its outcome." "Python helper"
                seeder = component "Event Seeder" "flask seed-events command that loads events from the event data file at setup." "Flask CLI command"
            }

            db = container "Database" "Users, events, orders, and the purchase-attempt log." "PostgreSQL 16" {
                tags "Database"
            }

            ratesFile = container "Exchange Rate Config File" "Static exchange rates per supported currency, edited by hand about once a semester and shipped with the application." "YAML file" {
                tags "File"
            }

            eventsFile = container "Event Data File" "Event list loaded once at setup." "JSON file" {
                tags "File"
            }
        }

        # Context and container relationships
        buyer -> webapp "Registers, browses events, and buys tickets using" "HTTPS"
        webapp -> db "Reads from and writes to" "SQLAlchemy, psycopg"
        webapp -> ratesFile "Reads exchange rates at start-up from"
        webapp -> eventsFile "Loads events at setup from"

        # Component relationships
        buyer -> auth "Registers and logs in using" "HTTPS"
        buyer -> catalog "Browses and searches events using" "HTTPS"
        buyer -> checkout "Buys tickets using" "HTTPS"
        buyer -> orders "Views confirmations and order history using" "HTTPS"
        checkout -> auth "Checks the session and USF flag with"
        checkout -> rateLoader "Gets the exchange rate from"
        checkout -> auditLogger "Logs the purchase attempt with"
        orders -> auth "Checks the session with"
        rateLoader -> ratesFile "Reads at start-up"
        seeder -> eventsFile "Reads"
        auth -> db "Reads and writes users in" "SQL"
        catalog -> db "Reads events from" "SQL"
        checkout -> db "Decrements tickets and inserts orders in" "SQL"
        orders -> db "Reads orders from" "SQL"
        auditLogger -> db "Inserts purchase attempts into" "SQL"
        seeder -> db "Inserts events into" "SQL"
    }

    views {
        systemContext eventhub "original-context-view" "Original context (Part 2, one actor)" {
            include *
            autoLayout lr
        }

        container eventhub "original-container-view" "Original containers (Calls 1-2)" {
            include *
            autoLayout lr
        }

        component webapp "original-component-view" "Original components of the Web Application (Calls 1-2)" {
            include *
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
            element "File" {
                shape Folder
                background #999999
            }
        }
    }
}
