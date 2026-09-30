# SOLARI-FRONTEND-PLAYBOOK — general project playbook (OEP-0002, Lab A)

Bootstrapped from: `docs/architecture/frontend/{decision-guide,policies,DataTable,searchers-and-filters}.md`
+ ticket-1 transcript (notification mail "responder a"). Not from before/after
diffs — these tickets are not migrations. Distillation, not a pointer to docs.

## Objetivo / cuándo aplica

Contexto para cualquier ticket de feature frontend en `solari_cloud`
(React sobre Rails, `#react-root`), no limitado a un tipo de tarea.

## Defaults de arquitectura (decision-guide.md)

- Ruta React completa si la pantalla necesita ownership claro / varias
  superficies coordinadas. Isla React si sigue acoplada a una vista Rails
  existente y el cambio es incremental.
- Estructura default de pantalla nueva: `index.js`, `FooContainer.jsx`,
  `Foo.jsx`, `pageActions/`, `table/`/`form/`/`hooks/` según necesidad.
- Server state → React Query. UI state → local/contexto chico. No usar
  contexto local como cache remoto.
- Regla general del repo: si una decisión nueva compite con un patrón ya
  maduro, el default es copiar el patrón maduro, no inventar uno nuevo.

## Policies — cómo se gatea UI

- Usar `usePolicy()` (provider global, `policyContext.tsx`, montado en
  `AppRoot.jsx`) → `policy(model, method)`. Lazy por modelo, cachea, agrupa
  con debounce.
- Nombres de modelo = nombre backend (`Client`, `Invoicing::BillingEntity`,
  etc.). Método = acción Pundit o endpoint (`create`, `update`,
  `search_collection`, `audits`, ...).
- `policy(...)` no solo gatea botones/tabs: también gatea si una collection
  o request auxiliar se dispara (`useCollections` + `checkPolicy`).
- Providers locales de `PoliciesProvider` existen en features viejas
  (ej. `BillingEntitys/common/policies/policiesContext.js`) — no es el
  patrón a imitar en código nuevo salvo que la pantalla ya lo use.
- `isAdminSupport()` hace bypass total: todas las policies devuelven `true`.
  No asumir que "policy false" es universal en QA con sesión admin support.

## DataTable — tabla reutilizable

- Usar `DataTable` por default para listados/selección/sort externo/subrows.
  No inventar tabla nueva salvo que realmente no cubra el caso.
- `DataTable` NO hace fetch. La pantalla resuelve datos, filtros, búsqueda.
- Sort es declarativo, no automático: sin `onSort` en el `sortKey`, el ícono
  aparece pero no hace nada.
- `columnStorageSetup` debe ser único por tabla (persiste en localStorage).
- `toggleable` + `show`: si se omite `show`, la columna arranca visible.
- Si envolvés `DataTable` con un `TableProvider` externo, hay que pasar
  `useExternalStore` — si no, `DataTable` crea su propio provider y el externo
  queda bypassed.
- `renderCell` suele concentrar lógica de negocio (badges, toggles, modales)
  — está bien, es el patrón del repo, pero conviene delegar a un componente
  columna chico si crece mucho.
- Columnas: `key`, `name`, `renderCell`, `width`, `align`, `stickyColumn`,
  `toggleable`, `show`, `sortKeys`. Helper de tipado:
  `components/table/helpers/createDataTableColumns.ts`.

## Búsqueda / filtros / paginación

- Estado compartido `pagination` (o similar) en contexto local de pantalla:
  `currentPage`, `total`, `total_count`, `isLoading`, `searchBar`, `filters`,
  `queryParams`. `searchBar + filters + currentPage + isLoading` es casi
  universal.
- Búsqueda básica → query `q[field_operator]=value`. Filtros avanzados →
  `filtersToRansackQuery(...)`. Ambos escriben al mismo `pagination`.
- Cualquier cambio de búsqueda/filtro resetea `currentPage` a `1` y marca
  `isLoading: true`.
- Para pantallas nuevas: `PageToolbar` (con `dinamicSearchbarSetup`/
  `searchbarSetup`, `filterSetup`, `countInfoSetup`, `createSetup`) es la
  base recomendada, no `newSearcher`/`AdvancedSearch` (legacy, sigue válido
  donde ya existe, no para código nuevo).
- `onChange` (confirma búsqueda) vs `onSearchByChange` (cambia criterio
  activo) son distintos en `SmartTypeahead` — importa cuando el campo
  visible no es 1:1 con el campo Ransack final.

## Gotchas descubiertos en los tickets de esta serie

- **T1 (notificaciones, control):** un flag "requerido condicionalmente" en
  este repo suele vivir como función pura consumida en dos puntos (el
  `abbr`/asterisco visual y la rama de validación) — cambiar el flag en el
  origen (la función), no parchear cada punto de consumo por separado. Si
  la función ya no distingue casos, borrar el `switch` muerto en vez de
  dejarlo con ramas inalcanzables.

- **T2 (CBU/Alias):** antes de asumir que un dato "no existe en el
  frontend," confirmar en el controller qué expone el `as_json`/serializer
  real. La sección "Estado actual" de un ticket puede estar desactualizada
  respecto al backend — el ticket dijo que faltaba, y ya estaba expuesto.
  Un patrón ya existente en el mismo archivo (mostrar un dato extra gateado
  por `gateway_name === 'X'`) es la primera referencia a buscar antes de
  inventar una UI nueva — pero verificar *qué* gatea (acá había un ejemplo
  gateado además por `isAdminSupport()`, que no aplicaba a este caso porque
  el público objetivo del ticket era justo el usuario sin ese permiso).

- **T3 (selectores que excluyen registros):** cuando un ticket pide
  "excluir X de un selector," antes de tocar el hook/contexto frontend que
  arma la URL del selector, revisar si ese selector llama a un endpoint
  `search_collection` compartido. Si es así, la exclusión va en el scope
  Ransack del backend, no en el frontend — filtrar client-side rompe
  paginación/conteos. Corolario: el listado de "rutas de referencia" de un
  ticket puede apuntar a archivos que no requieren cambio; confirmar cada
  uno contra el endpoint real antes de tocarlo.

- **Full-stack gaps:** si un ticket de frontend depende de un campo que no
  existe en el modelo backend (confirmado por grep en `app/models/` y
  `db/migrate/`), no asumir el shape del campo ni escribir el fix backend
  dentro de un shadow run — implementar solo la parte frontend de forma
  defensiva (chequeo estricto que no cambia el comportamiento actual) y
  dejarlo marcado como dependencia pendiente.

## Estado

Playbook v1 — bootstrap (T1) + write-back de T2 y T3. 3/3 tickets del Lab A
completos.
