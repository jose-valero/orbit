---
name: orbit-writeback
description: Después de implementar y verificar una tarea, actualiza el playbook de ORBIT con lo aprendido — nuevas convenciones, gotchas, fixes confirmados. Usar al cerrar un ticket/feature, después de orbit-derive.
---

# orbit-writeback

El otro lado del loop de `orbit-derive`. Sin esto, el playbook no mejora y
el mecanismo se degrada a "leer el mismo archivo de siempre" — la parte que
lo hace valer la pena es que se actualiza con lo que costó aprender.

## Paso 1 — identificar qué es "expensive to reconstruct"

De lo que acabás de implementar, preguntate: si mañana alguien (vos mismo)
tuviera que hacer algo parecido sin este contexto, ¿qué tardaría en volver
a descubrir? Solo eso va al playbook. No documentes lo que ya es obvio
leyendo el código.

Candidatos típicos: una convención que confirmaste pero no estaba escrita,
un gotcha que te costó tiempo, un defecto conocido que hay que arreglar (no
solo advertir) cada vez que aparece, una decisión de producto que alguien
tomó y que no es obvia del código.

## Paso 2 — ¿dónde va?

- Si encaja en un archivo de convención existente (`playbook/conventions/
  <tema>.md`), agregalo ahí, en el molde Regla/Por qué/Trampa/Dónde
  verificar/Precedente.
- Si es un tema nuevo, creá el archivo desde `CONVENTION.template.md`.
- Si no encaja en ningún tema puntual (es del proyecto en general), va en
  la sección "Gotchas transversales" del `PLAYBOOK.md`.

## Paso 3 — anclar a un precedente real

Cada entrada nueva debería poder señalar un lugar concreto donde se aplicó
— `archivo:línea`, un commit, un PR. Una regla sin precedente es una
hipótesis, no una convención confirmada; marcala como tal si todavía no
tenés el ancla.

**Regla dura (validada en OEP-0001): si vas a documentar un defecto
conocido, documentá el fix concreto, no una advertencia.** Una advertencia
sola no evitó que el mismo bug se repitiera tres veces en el experimento
que originó esta regla — el fix sí.

## Paso 4 — disciplina de tamaño

Si el archivo de convención que estás tocando va a superar ~150-200 líneas,
no seguile agregando — partilo por sub-tema. Si el índice `PLAYBOOK.md` va
a superar ~40 líneas, es señal de que el proyecto necesita más de un
playbook (por dominio, por capa) en vez de uno solo creciendo sin límite.

## Paso 5 — no resuelvas en silencio lo que quedó abierto

Si `orbit-derive` dejó una pregunta abierta o un hueco marcado, y seguís sin
tener la respuesta, el write-back **mantiene esa pregunta abierta** — no la
completes con una suposición para que el archivo se vea prolijo.

## Paso 6 — actualizar el índice y cerrar

- Si agregaste o cambiaste sustancialmente un archivo de convención,
  actualizá su línea de una-oración en `PLAYBOOK.md`.
- Actualizá la sección "Estado" del `PLAYBOOK.md` (fecha, contador de
  tickets procesados).
- El archivo `playbook/tickets/<slug>-context.md` de esta tarea ya cumplió
  su función — podés borrarlo o dejarlo como historial; si es la primera
  vez, preguntale al usuario qué prefiere y no vuelvas a preguntar después.
