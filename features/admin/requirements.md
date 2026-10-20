# admin

- **admin-001** (state-driven): While a signed-in user has the administrator role, the {EventHub} shall provide an administration area for managing exchange rates and reading the audit log.
- **admin-002** (unwanted): If a signed-in user without the administrator role requests any administration page or action, then the {EventHub} shall respond with an access-denied error and change no data.
- **admin-003** (event-driven): When a user who is not signed in requests any administration page, the {EventHub} shall redirect the user to the login page.
- **admin-004** (state-driven): While an administrator is viewing the exchange-rate page, the {EventHub} shall show each supported currency with its current rate against the US dollar and the time and administrator of its last change.
- **admin-005** (event-driven): When an administrator saves a new exchange rate for a supported currency, the {EventHub} shall use that rate for every price computed afterward without a restart or redeployment.
- **admin-006** (unwanted): If an administrator submits an exchange rate that is not a positive decimal number with at most six decimal places, then the {EventHub} shall reject it with the message "Invalid exchange rate." and keep the previous rate.
- **admin-007** (ubiquitous): The {EventHub} shall keep the US dollar rate fixed at 1 and offer no way to edit it.
- **admin-008** (state-driven): While an administrator is viewing the audit log, the {EventHub} shall list audit entries newest first and let the administrator filter them by account email, event, outcome, and date range.
- **admin-009** (ubiquitous): The {EventHub} shall display all audit log content in the administration area as plain text.
- **admin-010** (ubiquitous): The {EventHub} shall not call the administration component from any buyer-facing page or purchase step.
