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

- Date: 9-9-2026
- Sources used (/docs patterns, which old↔upgraded view pairs, ticket-1 transcript): pages/BillingReceipt (+README), pages/billingProfiles (+ components/forms/invoicing/invoicingProfile/), pages/Zone, pages/Neighborhood, pages/Employees, docs/architecture/frontend/{README, current-vs-legacy-patterns, decision-guide, legacy-to-frontend-migration-policy, data-strategy, forms, modals}, router/routes.jsx
- Operator minutes: 25 minutos
- Tokens (in / out / total): n/a
- USD: n/a
- Final playbook length (lines):
- Notes: Playbook construido leyendo ~15 archivos del repo; 6 decisiones de diseño resueltas por el operador.

---

## Baseline (de memoria, sin ORBIT)

- Ticket id / title:
- Size estimate (S/M/L): S
- Brief-writing minutes (full brief): medio dia por vista, contexto escrito a mano
- Tokens (in / out / total):
- USD: \_\_
- Human minutes (total):
- Wall-clock:
- Avoidable misunderstandings:
- Rework iterations:
- Regressions:
- Notes:

---

## Ticket 2 — ORBIT (Barrios)

- Ticket id / title: Ticket 2 — migrar `pages/Neighborhood` (Barrios)
- Size estimate (S/M/L): S — 1 campo (`name`), sin AdvancedSearch, sin soft-delete, sin deep-link
- Brief-writing minutes (delta brief): 1, ticket de una linea
- Tokens (in / out / total): pendiente — correr `/usage` al cierre de sesión
- USD: pendiente — de `/usage`
- Human minutes — prep (incl. brief): 1
- Human minutes — review of derived context: 10
- Human minutes — answering questions/decisions: 5
- Human minutes — review of implementation: 15
- Human minutes — interventions: 1
- Human minutes — write-back: 2
- Wall-clock: implementación ~15 min (desde "luz verde para implementar" hasta el primer "done"; + la pasada de rework de countInfo)
- Avoidable misunderstandings: 0 (0 redirecciones durante la implementación; las 8 preguntas de §8 se respondieron antes de codear)
- Rework iterations:2: dos fixes distintos después del primer "done"
- Regressions: 0 regresiones (validación manual completa post-impl). 1 defecto tour back-nav conocido, no crítico, diferido.
- Prior gotchas applied: 0 (no hay tickets ORBIT previos; 3 gotchas del bootstrap del playbook sí aplicaron — ver `neighborhood-context.md` §10)
- Derived-context correction (lines): 0
- Context size (derived / est. /docs): derivado ≈ 500 líneas (inventario 24 archivos + backend + checklist + verificación + write-back) / `/docs` alternativo (`decision-guide.md` + `forms.md`) describen el patrón legacy → habrían desviado
- Write-back tokens: incluido en total de sesión; write-back = 7 ediciones al playbook (209 líneas finales, < cap 300)
- Parity decisions by operator: 4 — #3 historial de búsqueda, #4 react=true, #5 búsqueda por id, #6 animaciones de fila.
- Playbook gaps found: 3 — #1 strings de policy, #7 carpetas, #8 createSetup. (+ 1 meta: el playbook no tiene un paso "decidí qué comportamientos menores del legacy portar")
- Notes: contexto derivado muy completo (inventario 24 archivos + backend Rails confirmado + 8 decisiones). Altitud alta pero útil para 1ª migración. Cambios de infra fuera de la vista, mínimos y esperados: +key `neighborhood` en `pageToolbar/actions/helpdocs/docs.ts`; +bloque `neighborhood.tour.*` en `locales/{es,en}/views.js`. 1 error tsc remanente en `table/Table.jsx` (TS2322 TableColumnData) idéntico al de `BillingReceipt`/`billingProfiles` → por eso `Table.jsx` sigue `.jsx`, no es regresión. Repo sin script `tsc`/`eslint`. `.gitignore` quedó con `+.orbit/` duplicado (no es de esta implementación).
- Reference defects surfaced: 2 (countInfo, tour back-nav)
  Defect found in review: 1

---

## Ticket 3 — ORBIT (Zonas)

- Ticket id / title: Ticket 3 — migrar pages/Zone
- Size estimate: S — 1 campo (name), CRUD en modal, sin AdvancedSearch/soft-delete/deep-link
- Brief-writing minutes: 1 (ticket de una línea)
- Tokens (in/out/total): [/cost en la sesión de solari] ← pendiente
- USD: [/cost] ← pendiente
- Human minutes — prep: 1
- Human minutes — review of derived context: 6
- Human minutes — answering questions/decisions: [3 minutos]
- Human minutes — review of implementation: 6 (item por item, post-impl; ya había probado en la vista)
- Human minutes — interventions (mid-impl): 0
- Human minutes — write-back: 1
- Wall-clock: derive ~6 min + implementación ~15 min
- Avoidable misunderstandings: 0
- Rework iterations: 0
- Regressions: 0 (validación manual completa: listar/scroll/buscar/contador/crear/editar/borrar/NewAudit/copy id/tour — OK)
- Prior gotchas applied: ~8 (sequential_id, total/total_count, edit sin GET :id, policy PascalCase, omitir ColumnFilterMenu, sin filterSetup, key helpdocs, cerrar modal antes de mover driver, reabrir fresco en back-nav)
- Derived-context correction (lines): 0 (aprobado item por item, sin cambios)
- Context size: 290 líneas (vs 525 Barrios, −45%)
- Playbook gaps found: 2 (createSetup sin ref nombrada; paso 8 ambigüedad AuditAction) + 1 menor (?react=true en mutations)
- Parity decisions by operator: 1 (solo NewAuditAction)
- Reference defects surfaced: 0
- Notes: 1 desviación menor flageada por el agente (mutations sin ?react=true, paridad legacy). Eligió bien.

---

## Ticket 4 — ORBIT (Empleados)

- Ticket id / title: Ticket 4 — migrar `pages/Employees`
- Size estimate (S/M/L): **L** — master-detail, form multi-tab (4 tabs), avatar
  upload, 2º form (cambio de password), 2 acciones de fila no-CRUD (unlock,
  toggle-active), filtro `password_expired`, auditoría doble (legacy + new),
  soft-delete (sin exponer borrado). La vista más grande de la serie.
- Brief-writing minutes (delta brief): 1 (ticket de una línea + "sin contexto de
  Barrios/Zonas")
- Tokens (in / out / total): `/cost` no da desglose; **sesión al 32%** del
  presupuesto al cierre de esta ronda.
- USD: n/a (solo % de sesión)
- Human minutes — prep (incl. brief): 1
- Human minutes — review of derived context: (el operador respondió los
  8 puntos de decisión de §7 en un solo pase)
- Human minutes — answering questions/decisions: 6minutos (8 decisiones
  respondidas juntas)
- Human minutes — review of implementation: 15 minutos
- Human minutes — interventions: 0 durante la implementación
- Human minutes — write-back: incluido en la sesión (2 rondas de write-back:
  post-impl + post-fixes)
- Wall-clock: implementación ~33 min (1 pase) + 2ª ronda de fixes tras review
- Avoidable misunderstandings: 0 (0 redirecciones; las 8 decisiones se
  respondieron antes de codear)
- Rework iterations: 3 — (a) ronda de fixes tras el 1er "done" (margen del
  contenedor, tour form→tabla back-nav, teléfonos+roles como columnas, avatar en
  col nombre, validación de fuerza de password, roles con `TagStackSelector`, nav a
  tab con error); (b) micro-ajustes: email vuelve debajo del nombre, avatar+nombre
  a la izquierda, roles del form revertidos a checkboxes; (c) **nuevo componente
  reutilizable `BadgeGroup`** (`components/stateful/badgeGroup/`) y roles de la
  tabla pasados a `BadgeGroup` (chip `N+` + popover, sin menús) en vez de
  `TagStackSelector`.
- Regressions: 0 introducidas por los fixes al momento (pendiente re-validación
  manual). `tsc` limpio en paths nuevos salvo el `TS2322` esperado de `Table.jsx`.
- Prior gotchas applied: ~10 del playbook — full-page `<PageToolbar>` (no
  CustomPageActions), `createSetup` gated (ref Seal), `Table.jsx` sigue `.jsx`
  (TS2322 esperado), `total`/`total_count` movidos los dos en alta/baja, merge de
  fila en edit, `AuditAction` legacy solo si alcanzable (acá SÍ lo está), mutations
  sin `?react=true` (paridad), tour: cerrar modal antes de mover el driver +
  `waitForElement`, `UIModal.open` para todo modal, `helpdocsSetup.model` requiere
  key en `docs.ts` (agregada `employee`).
- Derived-context correction (lines): 0 (el operador respondió las 8 decisiones de
  §7 sin editar el cuerpo del contexto; añadió 1 nota en §0.1 sobre el box)
- Context size (derived / est. /docs): derivado **794 líneas** (forma de la vista
  + mapa playbook-vs-nuevo de 20 filas + Rails confirmado + delta 12 pasos +
  checklist + 10 huecos/decisiones + §8 impl + §9 fixes 2ª ronda). `/docs`
  alternativo describía el patrón legacy → habría desviado.
- Playbook gaps found: varios (esperado, el ticket lo anticipaba) —
  (1) master-detail `box/` declarado fuera de alcance sin decir qué hacer;
  (2) form multi-tab cubierto por `invoicingProfile/layout/` pero no en el texto;
  (3) divergencia create/edit en un mismo tab; (4) upload de archivo / avatar sin
  mención; (5) 2º form (cambio de password); (6) acciones de fila no-CRUD (unlock,
  toggle-active); (7) mapeo del toggle `password_expired` → `FilterPanel`;
  (8) `Pin.*`/`DropzoneSingleFile` `.jsx` en `.tsx` (TS2604); (9) `_colors` default
  export en `.tsx`; (10) `unaccent_cont` es predicado global (partir el MAGIC_QUERY).
  Todos volcados al playbook (write-back t4).
- Parity decisions by operator: ~8 resueltas en §7 — box→columnas (contacto +
  roles como columnas, avatar en col nombre; sin panel ni card hover) · ResultCount
  por el pull (camino normal) · filtro en FilterPanel + toggle activo como acción de
  fila · responsive según refs (`PortalDropdown`→`ActionsDropdown`) · form de
  password en `components/forms/employee/` · borrado fuera de scope · EditAction
  por fetch (`/employees/:id/edit`) · roles: `BadgeGroup` (nuevo) en tabla,
  checkboxes legacy en el form.
- Reference defects surfaced: 2 reusados (countInfo doble contador, tour back-nav).
- Write-back (2 rondas): (1) post-impl — header fechado + master-detail en
  "Objetivo" + gotchas TS/form/backend + Estado. (2) post-fixes — 6 gotchas más
  (wrapper sin padding lateral, tour form→tabla back-nav, box→columnas no popover,
  nav a tab con error al submit, fuerza de password = territorio nuevo, roles con
  `TagStackSelector`). Cortado para el cap (~330 líneas finales): numeración de los
  4 bugs de tour de billingProfiles, gotcha `sequential_id`, bullet
  `useFloatingPortalProps`. Anotado en Estado.
- Infra fuera de la vista (mínima, esperada): +key `employee` en
  `pageToolbar/actions/helpdocs/docs.ts`; +bloques `views.employee.navtabs.*` y
  `views.employee.tour.*` en `locales/{es,en}/views.js`. Backend ya venía
  arreglado en la branch (`pagination_info` con `total_filtered`+`total`, commits
  `paginacion arreglada` / `fix controller`).
- Playbook gaps found (2ª ronda, review del operador): (11) `SC<Entity>Wrapper` no
  debe copiar el padding lateral legacy; (12) tour: el 1er step de tabla necesita
  `onPrevClick` que reabra el modal; (13) al matar un `box/` los campos van a
  columnas, no a un popover (decisión de producto a plantear explícitamente);
  (14) nav a la 1ª tab con error al fallar el submit (sale de billingProfiles);
  (15) fuerza de contraseña = territorio nuevo sin ref; (16) roles → `TagStackSelector`.
- Notes: 1er "done" a 125 archivos; 2ª ronda de fixes tras review del operador
  (~7 ítems) + micro-ajustes + `BadgeGroup`. Form reusable en
  `components/forms/employee/`. **Componente nuevo `BadgeGroup`**
  (`components/stateful/badgeGroup/`, 6 archivos): display read-only de un
  arreglo como badges, 3 visibles + chip `N+` con popover; se aplicó a los roles
  de la tabla. El input de roles del form quedó en checkboxes legacy.

---

## Staleness check (~2+ weeks after playbook built)

- Date:
- Lines of the playbook now wrong / outdated:
- Who noticed, and how:
- Did the ticket benefit? How:
- Notes:

---

## Rollup

| Ticket | Arm     | Brief min | USD | Total tokens | Human min | Rework | Regressions |
| ------ | ------- | --------- | --- | ------------ | --------- | ------ | ----------- |
| 1      | control |           |     |              |           |        |             |
| 2      | orbit   |           |     |              |           |        |             |
| 3      | orbit   |           |     |              |           |        |             |
| 4      | orbit   |           |     |              |           |        |             |

- Bootstrap cost (min / tokens / USD):
- Cumulative write-back cost by ticket 4 (min / tokens):
- Cumulative saving vs. control baseline by ticket 4:
- Verdict (feasible / not feasible / redirect):
