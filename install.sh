#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Uso:
  ./install.sh                     instalación global (symlinks en ~/.claude/skills)
  ./install.sh --project <ruta>    instalación solo en un proyecto (copia, no symlink)
  ./install.sh -h | --help
EOF
}

MODE="global"
PROJECT_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) MODE="project"; PROJECT_DIR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Opción desconocida: $1" >&2; usage; exit 1 ;;
  esac
done

ORBIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_or_warn() {
  local target="$1" linkname="$2"
  if [[ -e "$linkname" && ! -L "$linkname" ]]; then
    echo "⚠ $linkname ya existe y NO es un symlink — no lo toco. Revisalo a mano." >&2
    return
  fi
  ln -sfn "$target" "$linkname"
  echo "  $linkname -> $target"
}

if [[ "$MODE" == "global" ]]; then
  mkdir -p ~/.claude/skills
  echo "Symlinkeando skills:"
  link_or_warn "$ORBIT_ROOT/.claude/skills/orbit-derive"    ~/.claude/skills/orbit-derive
  link_or_warn "$ORBIT_ROOT/.claude/skills/orbit-writeback" ~/.claude/skills/orbit-writeback

  if [[ -f "$ORBIT_ROOT/BASELINE.md" ]]; then
    link_or_warn "$ORBIT_ROOT/BASELINE.md" ~/.claude/BASELINE.md
  else
    echo "  (sin BASELINE.md todavía en $ORBIT_ROOT — copiá BASELINE.template.md, completalo, y volvé a correr este script para symlinkearlo)"
  fi

  echo
  echo "Instalado. Verificá: abrí Claude Code en OTRA carpeta y confirmá que"
  echo "'orbit-derive' y 'orbit-writeback' aparecen en la lista de skills disponibles."

elif [[ "$MODE" == "project" ]]; then
  if [[ -z "$PROJECT_DIR" ]]; then
    echo "Falta la ruta del proyecto. Uso: ./install.sh --project <ruta>" >&2
    exit 1
  fi
  if [[ ! -d "$PROJECT_DIR" ]]; then
    echo "No existe el directorio: $PROJECT_DIR" >&2
    exit 1
  fi
  mkdir -p "$PROJECT_DIR/.claude/skills"
  for skill in orbit-derive orbit-writeback; do
    dest="$PROJECT_DIR/.claude/skills/$skill"
    if [[ -e "$dest" ]]; then
      echo "⚠ $dest ya existe — no lo piso. Borralo a mano si querés reinstalar." >&2
      continue
    fi
    cp -r "$ORBIT_ROOT/.claude/skills/$skill" "$dest"
    echo "  copiado: $dest"
  done

  echo
  echo "Instalado solo en $PROJECT_DIR (copia, no symlink — sobrevive si borrás"
  echo "este clon de orbit, y viaja con el proyecto si lo commiteás ahí)."
  echo "Verificá: abrí Claude Code parado en $PROJECT_DIR y confirmá que"
  echo "'orbit-derive' y 'orbit-writeback' aparecen listadas."
fi
