# identity

- **identity-001** (event-driven): When a visitor submits the registration form with a full name, an email address, and a password, the {EventHub} shall create an account for that visitor.
- **identity-002** (ubiquitous): The {EventHub} shall store each password only as a salted hash from a memory-hard password hashing function and shall never store, log, or transmit a password in plaintext.
- **identity-003** (unwanted): If a visitor registers with an email address that already belongs to an account, then the {EventHub} shall reject the registration with the message "An account with this email address already exists."
- **identity-004** (event-driven): When a visitor registers with an email address whose domain is usf.edu, compared without regard to letter case, the {EventHub} shall mark the account as eligible for the USF student discount.
- **identity-005** (event-driven): When a user submits a registered email address and its matching password, the {EventHub} shall start an authenticated session for that user.
- **identity-006** (unwanted): If a user submits an email address and password that do not match a registered account, then the {EventHub} shall reject the login with the message "Invalid email or password." without revealing which of the two was wrong.
- **identity-007** (event-driven): When a signed-in user selects log out, the {EventHub} shall end that user's session.
- **identity-008** (state-driven): While a user is not signed in, the {EventHub} shall deny access to the checkout page and the order history page and redirect the user to the login page. superseded by identity-012
- **identity-009** (ubiquitous): The {EventHub} shall give every account exactly one role, buyer or administrator, and shall give the buyer role to every account created through registration.
- **identity-010** (ubiquitous): The {EventHub} shall provide no web page, form, or request that grants or changes an account role.
- **identity-011** (event-driven): When an EventHub engineer runs the grant-admin management command on the server with the email address of an existing account, the {EventHub} shall give that account the administrator role.
- **identity-012** (event-driven): When a user who is not signed in requests any checkout or order history page, the {EventHub} shall redirect the user to the login page with the requested page kept as the return target.
  supersedes: identity-008
- **identity-013** (event-driven): When a user signs in after being redirected to the login page, the {EventHub} shall send the user to the return target page.
- **identity-014** (unwanted): If the return target given to the login page is not a relative path on the EventHub site, then the {EventHub} shall discard it and send the user to the event list after sign-in.
- **identity-015** (state-driven): While a user is not signed in, the {EventHub} shall show no part of any checkout or order history page, including a page whose address was pasted directly into the browser.
