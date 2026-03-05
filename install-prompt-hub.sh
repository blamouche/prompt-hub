#!/usr/bin/env bash
set -euo pipefail

REPO_ARCHIVE_URL="${PROMPT_HUB_ARCHIVE_URL:-https://codeload.github.com/blamouche/prompt-hub/tar.gz/refs/heads/main}"
TARGET_DIR="${PWD}/.prompt-hub"
AGENT_FILE="${PWD}/agents.md"

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

SRC_DIR=""
echo "Downloading prompt-library..."
if curl -fsSL "$REPO_ARCHIVE_URL" | tar -xz -C "$TMP_DIR"; then
  SRC_DIR="$(find "$TMP_DIR" -type d -path '*/prompt-library' | head -n 1)"
fi

if [[ -z "${SRC_DIR}" || ! -d "${SRC_DIR}" ]]; then
  if [[ -d "${PWD}/prompt-library" ]]; then
    echo "Download unavailable, using local prompt-library as fallback."
    SRC_DIR="${PWD}/prompt-library"
  else
    echo "Error: prompt-library not found in downloaded archive and no local fallback available." >&2
    exit 1
  fi
fi

mkdir -p "$TARGET_DIR"

# Update strategy:
# - core/domain: replace entirely from source.
# - app: merge by filename (overwrite same-name files, keep local-only files).
for section in core domain; do
  SRC_SECTION_DIR="$SRC_DIR/$section"
  TARGET_SECTION_DIR="$TARGET_DIR/$section"
  if [[ -d "$SRC_SECTION_DIR" ]]; then
    rm -rf "$TARGET_SECTION_DIR"
    mkdir -p "$TARGET_SECTION_DIR"
    cp -R "$SRC_SECTION_DIR"/. "$TARGET_SECTION_DIR"/
  fi
done

SRC_APP_DIR="$SRC_DIR/app"
TARGET_APP_DIR="$TARGET_DIR/app"
if [[ -d "$SRC_APP_DIR" ]]; then
  mkdir -p "$TARGET_APP_DIR"
  cp -R "$SRC_APP_DIR"/. "$TARGET_APP_DIR"/
fi

echo "Installed prompt library into: $TARGET_DIR"

DOMAIN_DIR="$TARGET_DIR/domain"
if [[ ! -d "$DOMAIN_DIR" ]]; then
  echo "Error: domain directory not found in $TARGET_DIR." >&2
  exit 1
fi

domain_files=()
while IFS= read -r file; do
  domain_files+=("$(basename "$file")")
done < <(find "$DOMAIN_DIR" -maxdepth 1 -type f -name '*.md' | sort)

if [[ ${#domain_files[@]} -eq 0 ]]; then
  echo "Error: no domain markdown files found in $DOMAIN_DIR." >&2
  exit 1
fi

echo ""
echo "Choose a domain file to use:"
for i in "${!domain_files[@]}"; do
  printf "%d) %s\n" "$((i + 1))" "${domain_files[$i]}"
done

action_choice=""
while true; do
  read -r -p "Enter choice [1-${#domain_files[@]}]: " action_choice
  if [[ "$action_choice" =~ ^[0-9]+$ ]] && (( action_choice >= 1 && action_choice <= ${#domain_files[@]} )); then
    break
  fi
  echo "Invalid choice. Please enter a number between 1 and ${#domain_files[@]}."
done

SELECTED_DOMAIN_FILE="${domain_files[$((action_choice - 1))]}"
CORE_FILE="$TARGET_DIR/core/core.md"
SELECTED_FILE_PATH="$DOMAIN_DIR/$SELECTED_DOMAIN_FILE"

if [[ ! -f "$CORE_FILE" ]]; then
  echo "Error: core file not found at $CORE_FILE." >&2
  exit 1
fi

{
  cat "$CORE_FILE"
  printf "\n\n"
  cat "$SELECTED_FILE_PATH"
  printf "\n"
} > "$AGENT_FILE"

echo ""
echo "Created: $AGENT_FILE"
echo "Using domain: $SELECTED_DOMAIN_FILE"
