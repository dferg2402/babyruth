# system

- **system-001** (ubiquitous): The {EventHub} shall validate every value that enters from a request, including form fields, quantities, currency codes, identifiers, and return targets, at the request boundary before any component uses it.
- **system-002** (unwanted): If a request value fails boundary validation, then the {EventHub} shall reject the request with a specific error message and change no stored data.
- **system-003** (state-driven): While a session has been idle for longer than the configured idle timeout, the {EventHub} shall treat the session as expired and require the user to sign in again.
- **system-004** (ubiquitous): The {EventHub} shall accept a state-changing request only when it carries a valid anti-forgery token bound to the user's session.
- **system-005** (ubiquitous): The {EventHub} shall serve every page and form over HTTPS only.
- **system-006** (ubiquitous): The {EventHub} shall escape all user-supplied text when rendering any page.
- **system-007** (ubiquitous): The {EventHub} shall apply no geographic, IP-based, or country-based restriction to registration or purchasing.
- **system-008** (ubiquitous): The {EventHub} shall keep every buyer page fully usable in a mobile web browser on screens 360 pixels wide or wider, with no native application required.
- **system-009** (ubiquitous): The {EventHub} shall let a signed-in buyer go from the event list to a completed purchase in under two minutes.
- **system-010** (state-driven): While up to 200 buyers submit purchases in the same second, the {EventHub} shall complete each purchase request within 3 seconds.
- **system-011** (ubiquitous): The {EventHub} shall run as a single Python Flask web application with one relational database.
