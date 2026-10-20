# pricing

- **pricing-001** (ubiquitous): The {EventHub} shall offer prices in every currency on the supported currency list.
- **pricing-002** (ubiquitous): The {EventHub} shall convert prices from US dollars using the static exchange rates kept in the exchange-rate configuration file. superseded by pricing-008
- **pricing-003** (complex): While a buyer's account is eligible for the USF student discount, when the buyer is quoted a price for an event within the configured discount scope, the {EventHub} shall reduce the ticket price by the configured discount percentage.
- **pricing-004** (event-driven): When a price is converted into another currency, the {EventHub} shall round the converted amount once, half up, to the number of decimal places that currency uses.
- **pricing-005** (ubiquitous): The {EventHub} shall compute every ticket price, discount, currency conversion, and order total in the pricing component only.
- **pricing-006** (ubiquitous): The {EventHub} shall represent every money amount as a whole number of the currency's smallest unit together with its currency code and shall never use floating-point numbers for money.
- **pricing-007** (ubiquitous): The {EventHub} shall apply the USF student discount to the US dollar price before converting the price into the buyer's currency.
- **pricing-008** (ubiquitous): The {EventHub} shall convert prices from US dollars using the exchange rate stored in the database for the selected currency at the moment the price is computed.
  supersedes: pricing-002
- **pricing-009** (event-driven): When an order is saved, the {EventHub} shall store on the order the unit price, discount, exchange rate, and total used to price it.
- **pricing-010** (unwanted): If the total computed at submission differs from the total shown on the checkout page, then the {EventHub} shall stop the purchase and show the updated total for the buyer to confirm.
