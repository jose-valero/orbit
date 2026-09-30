---
name: orbit-derive
description: Deriva el contexto mínimo necesario para una tarea de este proyecto, a partir del playbook de ORBIT (lo bootstrapea si no existe). Usar ANTES de implementar cualquier feature, fix o refactor — no reemplaza leer código, acota qué leer.
---

# orbit-derive

Mecanismo validado en OEP-0001/OEP-0002 de ORBIT: un playbook chico y
mantenido, más contexto derivado por tarea, reduce trabajo repetido y
malentendidos frente a reconstruir todo desde cero cada vez. Esta skill
automatiza los pasos que antes se hacían a mano.

## Paso 0 — ¿existe el playbook del proyecto?

Buscá `playbook/PLAYBOOK.md` en la raíz del proyecto actual.

- **Si no existe (proyecto nuevo o primera vez que se usa ORBIT acá):**
  bootstrapealo antes de seguir:
  1. Buscá `~/.claude/BASELINE.md`. Si existe, leelo — es la semilla de
     día 0. Si no existe ahí, preguntale al usuario dónde vive antes de
     asumir que no tiene uno.
  2. Leé la documentación de arquitectura que ya exista en el proyecto
     (README, `AGENTS.md`/`CLAUDE.md`, docs de convenciones, ADRs) si la
     hay. **Si ya es buena y está al día:** `PLAYBOOK.md` la **referencia**
     con un link — no la copies ni la reescribas ahí. El playbook solo
     existe para lo que esa documentación NO cubre: gotchas, convenciones
     confirmadas pero no escritas en ningún lado, y divergencias entre lo
     que la doc dice y lo que el código realmente hace (si encontrás una,
     anotala como hallazgo — gana el código, no la doc).
  3. Si hay código existente relevante al área de la tarea, leé 1-2
     archivos representativos — no todo el repo.
  4. Copiá `PLAYBOOK.template.md` y `conventions/CONVENTION.template.md`
     del propio ORBIT a `playbook/` del proyecto, y completá el índice con
     lo que ya sabés de los pasos 1-3. Puede empezar casi vacío — eso es
     correcto, no inventes convenciones que todavía no están confirmadas.
  5. Fijate si el `AGENTS.md`/`CLAUDE.md` del proyecto ya tiene un puntero
     a `playbook/`. Si no lo tiene, ofrecele al usuario agregarlo ahora
     desde `AGENTS-STANZA.template.md` (del repo `orbit`) — no lo agregues
     sin avisar, es un archivo que el usuario probablemente ya usa para
     otras cosas.
  6. Decile al usuario que acabás de bootstrapear el playbook y mostraselo
     antes de seguir.
- **Si existe:** seguí al paso 1.

## Paso 1 — leer el índice, no todo

Leé `playbook/PLAYBOOK.md` completo (es corto, esa es la idea). NO leas
automáticamente todos los archivos de `playbook/conventions/` — elegí solo
los que el índice indica como relevantes para la tarea que te pidieron.

## Paso 2 — leer lo puntual

Leé las convenciones elegidas + los archivos de código directamente
relevantes a la tarea (guiado por grep/búsqueda dirigida, no exploración
amplia del repo).

## Paso 3 — verificar contra la fuente real, no contra lo que asumís

Esta es la regla más importante de ORBIT, la que la evidencia (OEP-0002)
mostró que evita el error más caro: **antes de escribir código, confirmá
contra el artefacto real** (el modelo, el controller/endpoint, el schema)
cualquier afirmación de la tarea o de un doc que sea verificable. Un ticket
o un doc puede estar desactualizado en cualquier dirección — puede decir
que algo falta cuando ya existe, o dar por sentado algo que en realidad no
existe. No le creas a la descripción de la tarea ni a la documentación por
default: verificá lo que se pueda verificar.

## Paso 4 — escribir el contexto derivado

Escribí `playbook/tickets/<slug>-context.md` con:

- El pedido original (brief), tal como te lo dieron.
- El subconjunto de convenciones que aplica (resumen, no copia completa).
- Los archivos de código relevantes (lista con motivo de por qué cada uno).
- Una checklist de "hecho" escrita ANTES de implementar — no después.
- Una sección **"Preguntas abiertas / huecos encontrados"**: cualquier cosa
  ambigua, cualquier dependencia faltante (ej. un campo que no existe en el
  modelo), cualquier decisión de producto que no te corresponde tomar sola.
  No inventes una respuesta acá — dejalo explícito y parate.

## Paso 5 — parar y esperar revisión

Mostrale el archivo derivado al usuario. No empieces a implementar hasta
que lo revise — es el punto de control humano del loop, no un trámite.
