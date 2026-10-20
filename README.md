# EventHub Ticketing — team babyruth

CEN 4020 (Fall 2026) EventHub project. This repository holds the requirements and the C4 design for EventHub Ticketing version 1, a public Python/Flask ticketing website whose launch customer is USF.

## Layout

```
workspace.dsl            C4 model (Structurizr DSL): context, container, component, and purchase-path views
diagrams/                Structurizr Lite PNG exports of every view in workspace.dsl
features/<feature>/      EARS requirements, one folder per component, plus system/ for cross-cutting rules
docs/design.md           APIs, component interfaces, data model, data structures, algorithms
docs/decisions/          Architecture decision records (database, money, rates, admin role, ...)
docs/open-items.md       Questions the calls left open and what the design does meanwhile
docs/call-3-change-log.md  What Call 3 changed in the requirements, model, and design
submissions/             Per-assignment deliverables (Parts 1–3), incl. the original pre-Call-3 design
scripts/                 Diagram export tooling
grading/                 Instructor's eligibility-check scripts
```

## Requirements format

Each `features/<feature>/requirements.md` holds one requirement per line:

```
- **pricing-008** (ubiquitous): The {EventHub} shall convert prices ... at the moment the price is computed.
  supersedes: pricing-002
```

IDs are never renamed or reused. A rewritten requirement gets a new ID with an indented `supersedes:` line, and the old line stays in place ending with `superseded by <new-id>`.

## Viewing and exporting the diagrams

Open the workspace with Structurizr (Docker). The `structurizr/lite` image is deprecated and exits at start-up, so use its replacement, `structurizr local`:

```
docker run -it --rm -p 8080:8080 -v "$PWD:/usr/local/structurizr" structurizr/structurizr local
# then browse to http://localhost:8080/workspace/1
```

Validate the DSL (the same check the grading script runs when the CLI is installed):

```
docker run --rm -v "$PWD:/w" structurizr/structurizr validate -workspace /w/workspace.dsl
```

Export every view to `diagrams/` with Structurizr's own file names (`structurizr-1-<view-key>.png`):

```
(cd scripts && npm install)          # first time only
scripts/render-diagrams.sh           # final design  -> diagrams/
scripts/render-diagrams.sh original  # original design -> submissions/ai-project-part-3/original/diagrams/
```

You can also export by hand from the diagram toolbar. Keep the file names it produces, because they contain the view key.

## Eligibility check

```
python3 grading/check_part3.py .
```
