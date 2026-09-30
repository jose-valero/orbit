# metrics.md — ORBIT feasibility probe (OEP-0001)

Pre-registered metric definitions. Do not change definitions once ticket 1
has started. One block per ticket.

## Definitions

- **Brief-writing minutes** — operator minutes spent writing the per-ticket
  context. Control: the full brief from scratch. ORBIT: the delta brief
  only. This is the headline metric.
- **Tokens in/out/total** — from `/cost` at session end.
- **USD** — session cost from `/cost`.
- **Human minutes** — prep (incl. brief) + interventions + review +
  write-back. Break out write-back separately for ORBIT-arm tickets.
- **Wall-clock** — from "task decided" to "done" accepted.
- **Avoidable misunderstandings** — count of redirections where the needed
  information was knowable at the start.
- **Rework iterations** — passes after the first "done" claim.
- **Regressions** — bugs found in review or later.
- **Size estimate** — rough t-shirt size (S/M/L), for normalisation.
- **Prior gotchas applied** (ORBIT only) — count of playbook gotchas from
  earlier tickets that mattered here.
- **Derived-context correction** (ORBIT only) — lines the operator changed
  in `tickets/<id>-context.md` before execution.
- **Context size** (ORBIT only) — lines in the derived context vs. the
  `/docs` the operator would otherwise have leaned on.

---

## Upfront: bootstrapping VIEW-UPGRADE-PLAYBOOK.md (one-time)

- Date:
- Sources used (/docs patterns, which old↔upgraded view pairs, ticket-1 transcript):
- Operator minutes:
- Tokens (in / out / total):
- USD:
- Final playbook length (lines):
- Notes:

---

## Ticket 1 — CONTROL

- Ticket id / title:
- Size estimate (S/M/L):
- Brief-writing minutes (full brief):
- Tokens (in / out / total):
- USD:
- Human minutes (total):
- Wall-clock:
- Avoidable misunderstandings:
- Rework iterations:
- Regressions:
- Notes:

---

## Ticket 2 — ORBIT

- Ticket id / title:
- Size estimate (S/M/L):
- Brief-writing minutes (delta brief):
- Tokens (in / out / total):
- USD:
- Human minutes — prep (incl. brief):
- Human minutes — review of derived context:
- Human minutes — interventions:
- Human minutes — write-back:
- Wall-clock:
- Avoidable misunderstandings:
- Rework iterations:
- Regressions:
- Prior gotchas applied:
- Derived-context correction (lines):
- Context size (derived / est. /docs):
- Write-back tokens:
- Notes:

---

## Ticket 3 — ORBIT

*(copy the Ticket 2 block)*

---

## Ticket 4 — ORBIT

*(copy the Ticket 2 block)*

---

## Staleness check (~2+ weeks after playbook built)

- Date:
- Lines of the playbook now wrong / outdated:
- Who noticed, and how:
- Did the ticket benefit? How:
- Notes:

---

## Rollup

| Ticket | Arm | Brief min | USD | Total tokens | Human min | Rework | Regressions |
|--------|-----|-----------|-----|--------------|-----------|--------|-------------|
| 1 | control | | | | | | |
| 2 | orbit | | | | | | |
| 3 | orbit | | | | | | |
| 4 | orbit | | | | | | |

- Bootstrap cost (min / tokens / USD):
- Cumulative write-back cost by ticket 4 (min / tokens):
- Cumulative saving vs. control baseline by ticket 4:
- Verdict (feasible / not feasible / redirect):
