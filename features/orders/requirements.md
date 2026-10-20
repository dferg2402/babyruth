# orders

- **orders-001** (event-driven): When a purchase completes, the {EventHub} shall display an on-screen confirmation with the event name, quantity, currency, exchange rate applied, and total charged.
- **orders-002** (ubiquitous): The {EventHub} shall store each completed order linked to the account that placed it.
- **orders-003** (state-driven): While a buyer is signed in, the {EventHub} shall provide an order history page listing all of that buyer's orders, newest first.
- **orders-004** (event-driven): When a buyer selects an order on the order history page, the {EventHub} shall display that order's confirmation details.
- **orders-005** (ubiquitous): The {EventHub} shall deliver order confirmations on screen only and shall send no confirmation email.
- **orders-006** (unwanted): If a signed-in user requests an order that belongs to another account, then the {EventHub} shall respond with a page-not-found error and show none of that order's details.
