# Handoff — ORBIT feasibility probe (for the Claude Code agent in `solari_cloud`)

You are helping run a measured experiment. Full protocol: `OEP-0001` in the
ORBIT repo. This file is the operational summary. Do not philosophise about
ORBIT — just run the loop and record numbers.

## What we are testing

For a recurring task class — **upgrade a React view from the old
components / old methodology to the new ones** — whether a small maintained
playbook (`.orbit/VIEW-UPGRADE-PLAYBOOK.md`) lets the operator stop
rewriting the "how to do this upgrade" context from scratch every ticket,
and whether it beats the project's existing `/docs` for this task class.

## Files in `.orbit/`

- `VIEW-UPGRADE-PLAYBOOK.md` — the maintained playbook (built after ticket 1)
- `tickets/<id>-context.md` — context derived for each ORBIT-arm ticket
- `metrics.md` — the measurement log; fill one block per ticket

## Your role, by phase

### Ticket 1 — CONTROL
- The **operator writes the ticket brief** from scratch (they time it).
- You work the way you normally would, including using `/docs` as usual.
  **Do not use `VIEW-UPGRADE-PLAYBOOK.md`** (it does not exist yet).
- At the end, fill the ticket-1 block in `metrics.md` and run `/cost`.
- The operator keeps the full transcript.

### Building `VIEW-UPGRADE-PLAYBOOK.md` (after ticket 1)
Build it from three sources, distilled — not copied:
1. the relevant `/docs` patterns (view migration, forms, modals, …),
2. a diff of 2–3 pairs of (old-style view, already-upgraded view) the
   operator points you to — capture what actually changes and what `/docs`
   omits or gets wrong,
3. the ticket-1 transcript.
Use `VIEW-UPGRADE-PLAYBOOK.template.md`. Hard cap ~300 lines. Every line
must be **expensive to reconstruct**: a step, a component mapping, a
methodology rule, a constraint, a gotcha. It is a distillation, **not a
pointer to `/docs`**. Mark anything uncertain with `⚠ REVIEW`.

### Tickets 2…N — ORBIT
For each ticket, in order:
1. The **operator writes only a short delta brief** (which view,
   peculiarities). You do not write it.
2. **Derive** `tickets/<id>-context.md`: the delta brief + only the
   applicable parts of the playbook + the source files for that view + a
   "done" checklist written now, before any code.
3. **Stop.** Wait for the operator to review that file.
4. **Implement.**
5. **Verify** against the done checklist.
6. **Write-back**: append new gotchas and methodology rules to the
   playbook, update its `Estado`. Keep the ~300-line cap — if exceeded, cut
   the least-useful lines and note what you cut.
7. **Fill** the ticket block in `metrics.md`.

## What to record per ticket

- Operator minutes writing the ticket brief (control: full brief; ORBIT:
  delta only) — the operator gives you this number.
- Run `/cost` at session end → input tokens, output tokens, total, USD.
- Wall-clock time to "done".
- Count of times the operator had to redirect you because of a
  misunderstanding that **was avoidable**.
- Count of rework iterations after your first "done".
- ORBIT arm only: how many playbook gotchas from earlier tickets applied
  here; minutes + tokens spent on write-back; whether the operator edited
  the derived context and by how much (lines); derived-context size vs. the
  `/docs` you'd otherwise have leaned on.

## Rules

- Do not grow the playbook without bound. It is a liability when it holds
  things that rot.
- If the playbook and the code disagree, flag it — do not silently follow
  either.
- Report numbers honestly, including when the ORBIT loop was slower.
