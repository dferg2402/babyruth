# CEN 4020 EventHub Assignment Teamwork Reflection — Part 3

**Team's Name:** babyruth (Gold)

**Name:** Quang Minh Tran

**Teammates' Names:** Danae Ferguson

## Part 1: Roles

| Team Member | Driver | Navigator |
|---|---|---|
| Quang Minh Tran | 9 | 9 |
| Danae Ferguson | 8 | 9 |

## Part 2: Collaboration

| Team Member | Collaboration |
|---|---|
| Quang Minh Tran | 9 |
| Danae Ferguson | 9 |

## Part 3: Share of the work

| Team Member | Share of the work (%) |
|---|---|
| Quang Minh Tran | 70 |
| Danae Ferguson | 30 |
| **Total** | **100** |

## Part 4: Reflection

**1. What did you contribute to this assignment?**

I led Part 3 and made the final design decisions. I drove the GenAI tool to produce the original container and component diagrams from our Part 2 context diagram and Calls 1–2. I then decided how Call 3 changes the design:
- the second actor,
- moving rates into the database,
- splitting Checkout into Purchase, Pricing and Inventory,
- putting Audit into the purchase path,
- rejecting the checkout lock-in,
- choosing SQLite with load numbers.

I wrote and checked the final `workspace.dsl`, the EARS requirements in `features/`, the design decisions and their reasoning, and the developer-level design. I rendered the diagrams and ran the instructor's eligibility scripts on the repository. I also put together the assignment report.

**2. What did each of your teammates contribute to this assignment?**

Danae Ferguson gathered the details the design was built on:
- She went through the Call 3 transcript and extracted every change, decision and still-open question.
- She cross-checked Calls 1 and 2 to see which earlier open items Call 3 resolved and which it left open.
- As navigator, she reviewed the EARS requirements against the transcripts.
- She reviewed the rendered diagrams against what was said in the calls.

**3. Which AI tools did you use on this assignment, for which pieces of the work, and how did you check the output before it went into the submission?**

I used Claude Code (model Claude Opus 5.5) for these pieces of work:
- generating the original container and component diagrams from the Part 2 context diagram, our Part 1 requirements and the Call 1–2 transcripts,
- drafting the post-Call-3 Structurizr DSL, the EARS requirement lines, the decision records, the design document and a first draft of this report,
- writing the script that exports the diagrams.

I checked the output in four ways before it went into the submission:
- **Grading scripts:** I ran the instructor's `grading/check_part3.py` until it reported "ELIGIBLE for grading".
- **DSL:** both DSL files pass `structurizr validate`, and I opened the rendered diagrams to check that every element and arrow matches a decision from the calls.
- **Requirements:** Danae and I compared each requirement and decision with the transcript. Where the AI chose something the calls never decided, we marked it as provisional or open instead of presenting it as agreed. Examples are the admin mechanism and the discount-before-conversion order.
- **Original design:** I reviewed it for mistakes. One was that "decrements tickets in a transaction" does not by itself prevent overselling. Report section 2.3 lists what we found.

**4. What went well in how your team worked together?**

Splitting the work by strength worked well. Danae concentrated on the transcripts and the details, and I concentrated on the design decisions, so neither of us had to do both at once. Her list of what Call 3 resolved and what it left open made it easy to see which requirements had to be superseded and which questions had to stay open. Having her review the requirements and diagrams against the calls caught wording that went further than what the team had actually agreed.

**5. What will you change for the next assignment?**

I will commit work in smaller pieces as we go, with a `Co-authored-by:` trailer for whoever navigated, so the commit history shows both of our contributions. I also want to run the instructor's eligibility scripts from the start instead of near the end, and to bring Danae into the decision discussions earlier rather than only into the review.

**6. Is there anything the instructor or the TA should know about how this assignment went?**

The `structurizr/lite` Docker image is now deprecated. It prints a migration notice and exits instead of starting. We used its official replacement, `structurizr/structurizr local`, to open and export the workspace, and `structurizr validate` to confirm that `workspace.dsl` has no errors. The export file names still follow the `structurizr-1-<view-key>.png` pattern the check expects.
