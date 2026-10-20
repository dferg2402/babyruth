# audit

- **audit-001** (event-driven): When a purchase attempt ends in success or failure, the {EventHub} shall record an audit entry with the timestamp, account, event, quantity, currency, and outcome.
- **audit-002** (event-driven): When a purchase attempt fails, the {EventHub} shall record the specific failure reason in its audit entry.
- **audit-003** (ubiquitous): The {EventHub} shall write every purchase audit entry from inside the purchase path through a single audit component, so that no route writes audit entries on its own.
- **audit-004** (unwanted): If the audit entry for a successful purchase cannot be saved, then the {EventHub} shall roll back the purchase and report it to the buyer as failed.
- **audit-005** (ubiquitous): The {EventHub} shall keep audit entries append-only and shall provide no page or request that edits or deletes an audit entry.
- **audit-006** (event-driven): When an administrator changes an exchange rate, the {EventHub} shall record an audit entry with the timestamp, administrator account, currency, previous rate, and new rate.
