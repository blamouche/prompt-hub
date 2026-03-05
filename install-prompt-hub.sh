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
echo "Choose one or more domain files to use:"
for i in "${!domain_files[@]}"; do
  printf "%d) %s\n" "$((i + 1))" "${domain_files[$i]}"
done

action_choice=""
selected_indices=()
while true; do
  read -r -p "Enter choice(s) [1-${#domain_files[@]}] (comma/space separated): " action_choice
  selected_indices=()
  is_valid=true
  normalized_choice="${action_choice//,/ }"
  for token in $normalized_choice; do
    if [[ ! "$token" =~ ^[0-9]+$ ]] || (( token < 1 || token > ${#domain_files[@]} )); then
      is_valid=false
      break
    fi
    selected_indices+=("$token")
  done

  if [[ "$is_valid" == "true" && ${#selected_indices[@]} -gt 0 ]]; then
    break
  fi
  echo "Invalid choice. Enter one or more numbers between 1 and ${#domain_files[@]}, separated by commas or spaces."
done

CORE_FILE="$TARGET_DIR/core/core.md"
SELECTED_DOMAIN_FILES=()
selected_domains_seen="|"
for selected_index in "${selected_indices[@]}"; do
  candidate_file="${domain_files[$((selected_index - 1))]}"
  if [[ "$selected_domains_seen" != *"|$candidate_file|"* ]]; then
    SELECTED_DOMAIN_FILES+=("$candidate_file")
    selected_domains_seen="${selected_domains_seen}${candidate_file}|"
  fi
done

if [[ ! -f "$CORE_FILE" ]]; then
  echo "Error: core file not found at $CORE_FILE." >&2
  exit 1
fi

{
  echo "# Agents"
  echo ""
  echo "Use the following prompt files:"
  echo ""
  echo "- Core: \`./.prompt-hub/core/core.md\`"
  for selected_domain_file in "${SELECTED_DOMAIN_FILES[@]}"; do
    echo "- Domain: \`./.prompt-hub/domain/$selected_domain_file\`"
  done
  printf "\n"
} > "$AGENT_FILE"

selected_domains_display=""
for selected_domain_file in "${SELECTED_DOMAIN_FILES[@]}"; do
  if [[ -z "$selected_domains_display" ]]; then
    selected_domains_display="$selected_domain_file"
  else
    selected_domains_display="$selected_domains_display, $selected_domain_file"
  fi
done

echo ""
echo "Created: $AGENT_FILE"
echo "Using domains: $selected_domains_display"
