# inventory

- **inventory-001** (ubiquitous): The {EventHub} shall never sell more tickets for an event than the event's capacity, including when several purchases for the same event arrive at the same moment.
- **inventory-002** (event-driven): When a purchase passes the event, quantity, and currency checks, the {EventHub} shall check availability and the per-account limit, decrease the tickets remaining, and save the order as one indivisible database transaction.
- **inventory-003** (unwanted): If any part of the indivisible purchase transaction fails, then the {EventHub} shall leave the tickets remaining and the buyer's orders exactly as they were before the attempt.
