# ORBIT

ORBIT es un mecanismo personal para trabajar con IA en proyectos de
frontend: un playbook chico y mantenido por proyecto, contexto derivado por
tarea, y verificación contra la fuente real antes de escribir código.

No es un framework, no es un starter, no es una metodología general de
colaboración humano-IA. Esa fue la ambición original (ver `OEP/OEP-0000.md`)
y quedó descartada — no producía nada verificable. Lo que sobrevivió fue un
mecanismo mucho más chico y sí probado con evidencia real: **OEP-0001** y
**OEP-0002**.

## Qué es, concretamente

Dos capas:

- **`BASELINE.md`** (tuyo, cross-proyecto) — tu punto de partida
  estructural: stack por default, estructura de carpetas, hábitos de
  verificación. Vive versionado en **este repo** (no solo en tu máquina) y
  se symlinkea a `~/.claude/` — ver §Instalación. Sirve para sembrar un
  proyecto en día 0, cuando todavía no hay nada de qué destilar.
- **`playbook/` por proyecto** — un índice corto (`PLAYBOOK.md`) más
  archivos de convención chicos (`conventions/<tema>.md`, uno por tema, cada
  uno con su regla, su porqué, la trampa que rompe en silencio y un
  precedente real). Se bootstrapea del `BASELINE.md` + lo que ya exista del
  proyecto (docs, código), y crece con el uso. Vive y se commitea **dentro
  del repo de cada proyecto**, no acá.

Dos skills automatizan ese playbook, y un puntero corto en el `AGENTS.md` /
`CLAUDE.md` de cada proyecto lo hace legible por cualquier agente, aunque no
tenga la skill instalada — ver §Portabilidad más abajo.

- **`orbit-derive`** — antes de implementar algo: deriva el contexto
  mínimo necesario (bootstrapea el playbook si no existe), y **verifica
  contra la fuente real** antes de asumir nada de un ticket o de un doc.
- **`orbit-writeback`** — después de implementar y verificar: actualiza el
  playbook con lo aprendido. Nunca resuelve en silencio algo que quedó
  marcado como abierto.

Ver `.claude/skills/orbit-derive/SKILL.md` y `.claude/skills/orbit-writeback/SKILL.md`
para el detalle operativo.

## Por qué existe esto y no otra cosa

`OEP/OEP-0001.md` corrió el primer experimento: un playbook chico y
mantenido, derivado por ticket, superó a la documentación estática del
proyecto en una clase de tarea recurrente (migrar una vista de un patrón
viejo a uno nuevo). Resultado real, con matices — el mecanismo funcionó
para el núcleo estructural repetido, y un solo archivo capado no escaló a
una tarea de mucha superficie.

`OEP/OEP-0002.md` probó si eso generalizaba en dos ejes que quedaban
abiertos: tareas heterogéneas dentro de un mismo proyecto, y trabajo nuevo
sin nada previo de qué destilar (sin diffs antes/después). En ambos casos
el mecanismo se sostuvo — con muestra chica, pero sin fallar el criterio de
corte que se había definido de antemano.

La disciplina que más se repitió como causa del resultado, en los dos
experimentos, fue siempre la misma: **verificar contra la fuente real antes
de escribir código o de confiar en un ticket/doc**. Eso es lo que las dos
skills automatizan — no es una colección de reglas de un proyecto
específico, es un método que se puede rearmar en cualquier proyecto.

## Qué NO es

- No es un starter de React con archivos para Claude Code.
- No es una colección de skills o agentes genéricos.
- No pretende trascender frontend, ni un stack, ni un modelo de IA — el
  alcance actual es deliberadamente chico: uso personal, proyectos
  frontend, Claude Code.
- No está pensado (todavía) para venderse ni para otro equipo. Si eso
  cambia algún día, tiene que ganárselo con evidencia — no es el objetivo
  de partida.

## Historial (por qué está organizado así)

- `OEP/OEP-0000.md` — la fase de investigación abstracta que se abandonó.
  Se conserva como registro de qué se descartó y por qué, no como base.
- `OEP/OEP-0001.md` — primer experimento medido: el mecanismo del playbook,
  sobre una clase de tarea recurrente, en un proyecto real (nombres
  ficticios; el proyecto real es de un empleo, no se identifica).
- `OEP/OEP-0002.md` — segundo experimento: generalización del mecanismo a
  tareas heterogéneas y a trabajo sin precedente. Incluye el caso donde sí
  se usa el nombre real (AssetMind), porque es un proyecto propio.
- `playbook/`, `BASELINE.template.md`, `.claude/skills/` — lo que se
  construyó a partir de esa evidencia. Esto es lo que se usa de acá en
  adelante.

## Instalación

Este repo (`orbit`) es donde se **desarrolla** el mecanismo y donde vive
**tu `BASELINE.md` real** (no solo la plantilla) — es la única unidad que
tenés que llevar de una máquina a otra. No es algo que se clona o se
forkea dentro de cada proyecto nuevo: los proyectos nunca dependen de
tener este repo cerca, solo de lo que ya quedó copiado/symlinkeado en
`~/.claude/` y de lo que quedó commiteado en su propio `playbook/`.

**Primera vez en una máquina (esta o cualquier otra):**

```bash
git clone <tu-remoto-privado-de-orbit> ~/orbit   # o donde prefieras
cd ~/orbit
cp BASELINE.template.md BASELINE.md              # una sola vez en la vida
                                                  # de este repo; editalo y
                                                  # commitealo acá de ahí en más

mkdir -p ~/.claude/skills
ln -s ~/orbit/.claude/skills/orbit-derive    ~/.claude/skills/orbit-derive
ln -s ~/orbit/.claude/skills/orbit-writeback ~/.claude/skills/orbit-writeback
ln -s ~/orbit/BASELINE.md                    ~/.claude/BASELINE.md
```

**Verificá antes de dar por instalado:** abrí Claude Code parado en
*cualquier otra* carpeta (no en `orbit`) y confirmá que `orbit-derive` y
`orbit-writeback` aparecen en la lista de skills disponibles de esa sesión.
Si no aparecen, el problema está en el symlink, no en el contenido — es más
fácil de diagnosticar ahora que en medio de una tarea real.

En una máquina nueva, repetís exactamente este bloque después del
`git clone` — no se pierde nada de lo que ya tenías, porque `BASELINE.md`
viaja versionado adentro de `orbit`, no solo en `~/.claude/` de una máquina
puntual.

**Limitación conocida — Cowork / sesiones cloud.** Las skills instaladas a
nivel personal (`~/.claude/skills/`) **no cargan en sesiones Cowork o
cloud** — solo las de `.claude/skills/` dentro del propio repo del
proyecto cargan ahí (verificado contra la documentación oficial de
Skills). Si vas a trabajar un proyecto puntual también desde una sesión
cloud, copiá (no symlinkees) las dos carpetas de skill directo a
`<proyecto>/.claude/skills/` de ese repo, además del symlink global.

**Por cada proyecto (nuevo o existente) — no hay paso de instalación:**

1. Parate en el repo del proyecto (nuevo, vacío, o uno que ya existe con
   código).
2. Invocá `orbit-derive` con la primera tarea real. Si no existe
   `playbook/PLAYBOOK.md` en ese repo, la skill lo crea ahí mismo — leyendo
   tu `BASELINE.md` si el proyecto está vacío, o los docs/código que ya
   existan si no lo está.
3. Revisá el contexto derivado antes de dejar que se implemente.
4. Al cerrar la tarea, invocá `orbit-writeback`.
5. `playbook/` queda commiteado **dentro del repo del proyecto** — no en
   `orbit`. Es correcto que viva ahí: evoluciona con ese código específico,
   no con vos.

No hay instalador porque no hace falta uno para dos symlinks y un archivo
de texto — un script de instalación es exactamente el tipo de
infraestructura de más que este proyecto decidió no construir todavía. Si
algún día esto se usa en más de una máquina con la frecuencia suficiente
para que copiar 4 líneas de bash duela, ahí se justifica un instalador —
no antes.

## Portabilidad — qué tan atado está esto a Claude Code

Está atado, pero menos de lo que parece, y a propósito no se arregló del
todo — ver por qué abajo.

**Lo que SÍ es específico de Claude Code:** el mecanismo de skills
(`SKILL.md` + el tool `Skill`) que automatiza bootstrapear, derivar y
escribir de vuelta. Eso no lo lee Codex, Cursor ni ningún otro agente de
forma nativa.

**Lo que NO es específico de nada:** `BASELINE.md`, `playbook/PLAYBOOK.md`
y cada `conventions/<tema>.md` son markdown plano. Cualquier agente que
pueda leer archivos puede seguir el mismo loop a mano si alguien le dice
dónde están y qué hacer con ellos — lo único que pierde sin la skill es la
automatización de los pasos, no el conocimiento acumulado.

**El puente entre las dos cosas es `AGENTS.md`.** Confirmado (2026-09,
docs oficiales): Claude Code hoy reconoce `AGENTS.md` de forma nativa
(usa `CLAUDE.md` si existe; si no, cae a `AGENTS.md`; configurable para
leer ambos), y `AGENTS.md` es además una convención que ya comparten
Cursor, Copilot y otros — no es algo propio de Claude. Por eso cada
proyecto que use ORBIT debería tener, en su `AGENTS.md` (o `CLAUDE.md` si
es lo que ese proyecto usa), un puntero corto — no una copia — al
`playbook/`:

```markdown
## Antes de implementar algo en este proyecto

Este proyecto mantiene un playbook en `playbook/PLAYBOOK.md`. Leelo antes
de empezar cualquier feature/fix — indexa las convenciones relevantes en
`playbook/conventions/`. Si tenés la skill `orbit-derive` disponible, usala;
si no, seguí el mismo criterio a mano: verificar contra la fuente real
antes de asumir algo de un ticket o de un doc, y actualizar el playbook
al terminar.
```

Con esas 5 líneas, el día que cambies de agente (o que uses dos en
paralelo), el conocimiento acumulado en `playbook/` sigue siendo útil —
se pierde la automatización, no el contenido. **No se construyó una capa
de abstracción multi-agente además de esto**, a propósito: sería
exactamente la generalización prematura que ya mató la primera versión de
ORBIT (`OEP-0000`). Si el día de mañana usás Codex en serio, el costo real
es reescribir dos archivos de instrucciones chicos — no reconstruir nada
del mecanismo.
