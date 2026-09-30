# BASELINE.md — tu punto de partida estructural, cross-proyecto

> Esto no pertenece a ningún proyecto — es la base con la que arrancás
> cualquiera. Se usa para sembrar el `playbook/PLAYBOOK.md` de un proyecto
> en día 0, cuando todavía no hay código ni docs de dónde destilar nada.
> Completalo una sola vez y actualizalo cuando cambies de decisión sobre
> algo — no por proyecto, para siempre. Vive en `~/.claude/BASELINE.md`
> (ver `README.md` §Instalación) para que las skills lo encuentren solas.

## Stack por default (frontend)

<!-- Lo que elegís salvo que el proyecto te obligue a otra cosa.
     - Framework: ...
     - Server state: ...
     - Forms: ...
     - UI kit: ...
     - Testing: ... -->

## Estructura de carpetas por default

<!-- Cómo organizás un proyecto nuevo antes de que tenga convenciones
     propias. Ej: features/<name>/{api,hooks,components,pages}. -->

## Cómo arrancás un proyecto nuevo (día 0, repo vacío)

<!-- Los comandos concretos de scaffold que corrés antes de que exista
     ningún código — create-vite, config de TS/ESLint, lo mínimo para que
     el repo compile y corra. Esto es DISTINTO de "arrancar un feature":
     acá todavía no hay proyecto, solo carpeta vacía.
     Ej: `npm create vite@latest -- --template react-ts`, luego instalar
     <tus libs por default>, configurar <tsconfig/eslint/paths>. -->

## Cómo arrancás un feature nuevo (proyecto ya existe)

<!-- Los pasos que repetís siempre, en orden, antes de escribir la primera
     línea de código de una feature, asumiendo que el proyecto ya tiene
     esqueleto. -->

## Cosas que verificás siempre, sin que nadie te lo pida

<!-- Ej: "antes de asumir que un endpoint no existe, greppeo el backend
     real" — hábitos que ya demostraste que te ahorran tiempo. -->

## Cosas que NUNCA hacés

<!-- Antipatrones que ya identificaste en trabajo anterior. -->

## Estado

- Última actualización: <fecha>
- Proyectos sembrados con esto: <lista>
