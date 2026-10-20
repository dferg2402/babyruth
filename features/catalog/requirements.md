# catalog

- **catalog-001** (ubiquitous): The {EventHub} shall list every event whose scheduled start time has not passed, ordered from the soonest start time to the latest.
- **catalog-002** (ubiquitous): The {EventHub} shall leave out of the event list every event whose scheduled start time has passed.
- **catalog-003** (event-driven): When a user submits a search term, the {EventHub} shall list the upcoming events whose artist name or venue name contains that term, ignoring letter case.
- **catalog-004** (event-driven): When a user clicks once on an event card, the {EventHub} shall open that event's detail page.
- **catalog-005** (ubiquitous): The {EventHub} shall show on each event detail page the event name, artist, venue, start date and time, base ticket price, and number of tickets remaining.
- **catalog-006** (event-driven): When a user loads or refreshes an event detail page, the {EventHub} shall show the number of tickets remaining as stored at the moment of that request.
- **catalog-007** (event-driven): When an EventHub engineer runs the seed-events management command with an event data file, the {EventHub} shall load every event in that file with its tickets remaining set to its capacity.
- **catalog-008** (event-driven): When a search term matches no upcoming event, the {EventHub} shall show a message that no events match the search, followed by the full list of upcoming events.
- **catalog-009** (ubiquitous): The {EventHub} shall display any search text it repeats back to the user as plain text and never interpret it as markup or script.
