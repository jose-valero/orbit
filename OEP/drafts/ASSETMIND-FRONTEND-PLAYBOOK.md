# ASSETMIND-FRONTEND-PLAYBOOK — general project playbook (OEP-0002, Lab B)

Bootstrapped from: `docs/DECISIONS.md` + `CLAUDE.md` + the ticket-1
transcript (Inspecciones global list page). No before/after diffs — this
project has no legacy version, everything here is greenfield.

## Reality check before anything else

`services/api/` does **not exist** — zero Go code. Every doc that describes
a backend (`API_CONTRACT_DRAFT.md`, `BACKEND_ARCHITECTURE.md`, ADR-011's
`openapi.yaml`) describes a plan, not running code. The actual source of
truth today is the mock API layer (`api/mock/`, `VITE_API_MODE=mock`) and
the frontend types in `api/types.ts`. Do not assume a backend endpoint
exists because a doc names it — grep `services/` first.

Also: the product is named "AssetMind" in the repo/CLAUDE.md but "AssetLens"
in ADR-012. Pick the repo name (AssetMind) unless told otherwise; don't
"fix" the doc as part of an unrelated ticket.

## List-page pattern (the shape that matters most for this playbook)

Every list screen (`AssetsPage.tsx` is the reference) follows the same
skeleton — copy it, don't reinvent:

```
PageContainer
  PageHeader (title, description, optional actions)
  Toolbar (search: {value,onChange,placeholder}, filters: <selects + clear
           button>, actions: <result count>)
  isLoading -> PageSpinner
  error -> inline bg-fail-bg box
  empty (no data at all) -> EmptyState with icon+action
  empty (filtered to zero) -> EmptyState with "clear filters" action
  data -> a Table component (own file under components/)
```

- Filtering is **client-side** against a `useMemo`, even though the hook
  fetches with `page_size: 500`. Not paginated server-side yet. This is
  fine at MVP scale — don't add server-side filtering unprompted.
- Filter `<select>` state always defaults to `''` (empty string), typed as
  `T | ''`, never `undefined`. `hasActiveFilters` is derived from truthiness
  of all filter values, used both for the "Limpiar" button and for showing
  "X de Y" in the result count.

## Data layer pattern (per feature folder)

```
features/<name>/
  api/<name>Api.ts      — isMock ? mock.fn() : api.<verb>(url)   (both branches always written, even if the real endpoint doesn't exist yet)
  api/<name>Mock.ts      — reads/writes api/mock/mockStorage.ts
  api/<name>Keys.ts      — queryKey factory: all -> lists()/details() -> list(...)/detail(id)
  hooks/use<Name>.ts      — one hook per query, thin wrapper over useQuery
  components/            — presentational, receive data as props
  pages/                  — compose hooks + components
```

- Cross-cutting/global queries (e.g. "all X across every asset", not
  "X for one asset") get their own key branch (`listAll()`) and their own
  hook (`useAllX`) — don't overload the per-asset hook with an optional
  `assetId`.
- To join two entities client-side (e.g. inspection → asset tag/name),
  fetch both with their existing hooks and build a `Map` with `useMemo`
  keyed by id. Don't denormalize on the backend/mock side for MVP.

## UI conventions

- Badges: `StatusBadge` + a `<X>Variant(value)` helper function per enum
  (see `StatusBadge.tsx`: `inspectionResultVariant`, `assetStatusVariant`).
  If a feature-specific badge wraps this with fixed labels (e.g.
  `InspectionResultBadge`), reuse it — don't call `StatusBadge` directly
  when a wrapper already exists.
- Labels: every enum has a `Record<Enum, string>` in `lib/labels.ts`, in
  Spanish. New enums get a new export there, not inline ternaries.
- Tables: raw `<table>` with Tailwind utility classes (no table library).
  Alternating row background via `i % 2 === 0`, `overflow-x-auto` wrapper,
  `hidden md:table-cell` etc. for responsive column hiding. Row `onClick`
  navigates; action cells that contain their own links call
  `e.stopPropagation()`.
- Routing: paths live in one file (`router/paths.ts`) as plain functions/
  strings, never hardcoded route strings in components. New route → add to
  `paths.ts`, `router/index.tsx`, and `Sidebar.tsx` (3 files, always
  together).

## Gotchas discovered in this series

- **No `.gitignore` in the repo root.** `node_modules/`, `package-lock.json`
  and `yarn.lock` show as untracked. Not this ticket's problem to fix —
  don't `git add -A`, stage files explicitly.
- **Two lockfiles present** (`package-lock.json` and `yarn.lock`) — sign of
  mixed package-manager usage at some point. Don't regenerate either as a
  side effect of unrelated work.
- `tsc -b --noEmit` (`npm run typecheck`) is fast and catches the real
  class of error this stack produces (prop-shape mismatches between a new
  page and existing badge/table components) — run it after any new
  page/component, don't skip it because "it's just JSX."

## Estado

Playbook v1 — bootstrap from control ticket (Inspecciones global list).
