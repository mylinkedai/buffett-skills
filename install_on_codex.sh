#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/skills/buffett"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
DEST_DIR="${CODEX_HOME}/skills/buffett"
FORCE=0

usage() {
  cat <<EOF
Usage: $(basename "$0") [--force]

Installs the buffett skill into Codex at:
  ${DEST_DIR}

Options:
  --force    Overwrite an existing installation
  -h, --help Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]; then
  echo "Skill source not found: ${SOURCE_DIR}/SKILL.md" >&2
  exit 1
fi

mkdir -p "${CODEX_HOME}/skills"

if [[ -e "${DEST_DIR}" ]]; then
  if [[ "${FORCE}" -ne 1 ]]; then
    echo "Destination already exists: ${DEST_DIR}" >&2
    echo "Re-run with --force to overwrite it." >&2
    exit 1
  fi
  rm -rf "${DEST_DIR}"
fi

cp -R "${SOURCE_DIR}" "${DEST_DIR}"

echo "Installed buffett skill to:"
echo "  ${DEST_DIR}"
echo
echo "Restart Codex to pick up the new skill."
