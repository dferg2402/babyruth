# purchase

- **purchase-001** (state-driven): While a buyer is signed in, the {EventHub} shall let the buyer choose a ticket quantity and a currency from the supported currency list on the checkout page.
- **purchase-002** (event-driven): When a buyer submits a purchase, the {EventHub} shall check the event, quantity, and currency on the server before any ticket count changes.
- **purchase-003** (unwanted): If a submitted quantity is zero, negative, not a whole number, or greater than the configured per-order limit, then the {EventHub} shall reject the purchase with the message "Invalid quantity."
- **purchase-004** (unwanted): If a submitted currency code is not on the supported currency list, then the {EventHub} shall reject the purchase with the message "Unsupported currency."
- **purchase-005** (unwanted): If the event has zero tickets remaining at the moment the purchase is processed, then the {EventHub} shall reject the purchase with the message "Sold out."
- **purchase-006** (unwanted): If the event has fewer tickets remaining than the requested quantity but more than zero, then the {EventHub} shall reject the purchase with a message that states how many tickets remain.
- **purchase-007** (unwanted): If a purchase would bring the buyer's total tickets for one event above the configured per-account limit for that event, then the {EventHub} shall reject the purchase with the message "Purchase limit reached for this event."
- **purchase-008** (unwanted): If the submitted event does not exist or has already started, then the {EventHub} shall reject the purchase with the message "This event is not available for purchase."
- **purchase-009** (ubiquitous): The {EventHub} shall show a different error message for each different cause of a failed purchase.
- **purchase-010** (ubiquitous): The {EventHub} shall complete the payment step as a simulated payment and shall contact no external payment service.
- **purchase-011** (event-driven): When a signed-in buyer double-clicks an event card, the {EventHub} shall submit a purchase of one ticket for that event, subject to every purchase check, in the currency of the buyer's most recent order or in US dollars for a buyer with no orders.
- **purchase-012** (event-driven): When a user who is not signed in double-clicks an event card, the {EventHub} shall redirect the user to the login page and record no purchase.
- **purchase-013** (ubiquitous): The {EventHub} shall create an order only when a purchase completes and shall create no checkout or order record for a user who is not signed in.
- **purchase-014** (unwanted): If a buyer leaves the checkout page without confirming the purchase, then the {EventHub} shall leave the ticket count unchanged and keep no record of the unfinished checkout.
- **purchase-015** (unwanted): If the same checkout form is submitted more than once, then the {EventHub} shall create at most one order from it and show the confirmation of that order.
- **purchase-016** (ubiquitous): The {EventHub} shall leave the browser back button, page reload, and tab closing working normally on every checkout page.
- **purchase-017** (event-driven): When a buyer selects cancel on the checkout page, the {EventHub} shall return the buyer to the event detail page with the ticket count unchanged.
- **purchase-018** (ubiquitous): The {EventHub} shall process every purchase through the identity, catalog, pricing, inventory, and audit components in that order.
