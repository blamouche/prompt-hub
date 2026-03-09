#!/usr/bin/env bash
set -euo pipefail

# ── Colors & styles ──────────────────────────────────────────────────────────
if [[ -t 1 ]]; then
  BOLD="\033[1m"
  DIM="\033[2m"
  CYAN="\033[36m"
  GREEN="\033[32m"
  YELLOW="\033[33m"
  RED="\033[31m"
  MAGENTA="\033[35m"
  RESET="\033[0m"
else
  BOLD="" DIM="" CYAN="" GREEN="" YELLOW="" RED="" MAGENTA="" RESET=""
fi

info()    { echo -e "  ${CYAN}${BOLD}→${RESET}  $*"; }
success() { echo -e "  ${GREEN}${BOLD}✔${RESET}  $*"; }
warn()    { echo -e "  ${YELLOW}${BOLD}!${RESET}  $*" >&2; }
error()   { echo -e "  ${RED}${BOLD}✘${RESET}  $*" >&2; }
step()    { echo -e "\n${BOLD}${MAGENTA}▸ $*${RESET}"; }

# ── Banner ───────────────────────────────────────────────────────────────────
echo -e ""
echo -e "${CYAN}${BOLD}  ██████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ████████╗${RESET}"
echo -e "${CYAN}${BOLD}  ██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝${RESET}"
echo -e "${CYAN}${BOLD}  ██████╔╝██████╔╝██║   ██║██╔████╔██║██████╔╝   ██║   ${RESET}"
echo -e "${CYAN}${BOLD}  ██╔═══╝ ██╔══██╗██║   ██║██║╚██╔╝██║██╔═══╝    ██║   ${RESET}"
echo -e "${CYAN}${BOLD}  ██║     ██║  ██║╚██████╔╝██║ ╚═╝ ██║██║        ██║   ${RESET}"
echo -e "${CYAN}${BOLD}  ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝        ╚═╝   ${RESET}"
echo -e "${CYAN}${BOLD}  ██╗  ██╗██╗   ██╗██████╗ ${RESET}"
echo -e "${CYAN}${BOLD}  ██║  ██║██║   ██║██╔══██╗${RESET}"
echo -e "${CYAN}${BOLD}  ███████║██║   ██║██████╔╝${RESET}"
echo -e "${CYAN}${BOLD}  ██╔══██║██║   ██║██╔══██╗${RESET}"
echo -e "${CYAN}${BOLD}  ██║  ██║╚██████╔╝██████╔╝${RESET}"
echo -e "${CYAN}${BOLD}  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ${RESET}"
echo -e "${DIM}  AI Agent Prompt Library Installer${RESET}"
echo -e ""

# ── Config ───────────────────────────────────────────────────────────────────
REPO_OWNER_REPO="${PROMPT_HUB_REPO:-blamouche/prompt-hub}"
REPO_REF="${PROMPT_HUB_REF:-main}"
REPO_ARCHIVE_URL="${PROMPT_HUB_ARCHIVE_URL:-https://codeload.github.com/${REPO_OWNER_REPO}/tar.gz/refs/heads/${REPO_REF}}"
GITHUB_TOKEN="${PROMPT_HUB_GITHUB_TOKEN:-${GITHUB_TOKEN:-}}"
TARGET_DIR="${PWD}/.prompt-hub"
AGENT_FILE="${PWD}/agents.md"
CLAUDE_FILE="${PWD}/CLAUDE.md"

TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

# ── Download ─────────────────────────────────────────────────────────────────
step "Downloading prompt-library"

SRC_DIR=""
PROMPT_HUB_VERSION="unknown"
download_failed=false

if [[ -n "$GITHUB_TOKEN" ]]; then
  if curl -fsSL \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "$REPO_ARCHIVE_URL" | tar -xz -C "$TMP_DIR"; then
    SRC_DIR="$(find "$TMP_DIR" -type d -path '*/prompt-library' | head -n 1)"
  else
    download_failed=true
  fi
else
  if curl -fsSL "$REPO_ARCHIVE_URL" | tar -xz -C "$TMP_DIR"; then
    SRC_DIR="$(find "$TMP_DIR" -type d -path '*/prompt-library' | head -n 1)"
  else
    download_failed=true
  fi
fi

if [[ "$download_failed" == "true" && -z "$GITHUB_TOKEN" ]]; then
  error "Download failed. If the repository is private, set PROMPT_HUB_GITHUB_TOKEN (or GITHUB_TOKEN)."
fi
if [[ "$download_failed" == "true" && -n "$GITHUB_TOKEN" ]]; then
  error "Download failed with provided token. Check token scope and repository access."
fi

if [[ -z "${SRC_DIR}" || ! -d "${SRC_DIR}" ]]; then
  if [[ -d "${PWD}/prompt-library" ]]; then
    warn "Download unavailable — using local prompt-library as fallback."
    SRC_DIR="${PWD}/prompt-library"
  else
    error "prompt-library not found in downloaded archive and no local fallback available."
    exit 1
  fi
fi

if [[ -f "$SRC_DIR/version.md" ]]; then
  PROMPT_HUB_VERSION="$(head -n 1 "$SRC_DIR/version.md" | tr -d '[:space:]')"
fi
[[ -z "$PROMPT_HUB_VERSION" ]] && PROMPT_HUB_VERSION="unknown"

success "Prompt Hub ${BOLD}v${PROMPT_HUB_VERSION}${RESET}"

# ── Install files ─────────────────────────────────────────────────────────────
step "Installing prompt library"

mkdir -p "$TARGET_DIR"

# Migrate legacy root-level user files to .prompt-hub/ if they exist.
for legacy_file in memory.md version.md releases.md; do
  if [[ -f "$PWD/$legacy_file" ]]; then
    dest="$TARGET_DIR/$legacy_file"
    if [[ ! -f "$dest" ]]; then
      mv "$PWD/$legacy_file" "$dest"
      info "Migrated ${legacy_file} → .prompt-hub/${legacy_file}"
    else
      warn "${legacy_file} exists at root and in .prompt-hub/ — keeping .prompt-hub/ version."
    fi
  fi
done

# Update strategy:
# - notice.md, core/domain: replace entirely from source.
# - app: merge from source; replace files with identical relative paths.
# - memory.md, version.md, releases.md in TARGET_DIR are never touched (user-owned).
if [[ -f "$SRC_DIR/notice.md" ]]; then
  cp "$SRC_DIR/notice.md" "$TARGET_DIR/notice.md"
fi

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

# Always write the installed prompt-hub version so the auto-update check can compare it.
# This is separate from .prompt-hub/version.md which tracks the local repo version.
echo "$PROMPT_HUB_VERSION" > "$TARGET_DIR/prompt-hub-version.md"

success "Installed into ${DIM}${TARGET_DIR}${RESET}"

# ── Domain selection ──────────────────────────────────────────────────────────
step "Selecting domains"

DOMAIN_DIR="$TARGET_DIR/domain"
if [[ ! -d "$DOMAIN_DIR" ]]; then
  error "Domain directory not found at ${DOMAIN_DIR}."
  exit 1
fi

domain_files=()
while IFS= read -r file; do
  domain_files+=("$(basename "$file")")
done < <(find "$DOMAIN_DIR" -maxdepth 1 -type f -name '*.md' | sort)

if [[ ${#domain_files[@]} -eq 0 ]]; then
  error "No domain markdown files found in ${DOMAIN_DIR}."
  exit 1
fi

selected_indices=()

# Non-interactive mode: PROMPT_HUB_DOMAINS can be a comma/space-separated list of domain filenames.
if [[ -n "${PROMPT_HUB_DOMAINS:-}" ]]; then
  normalized_domains="${PROMPT_HUB_DOMAINS//,/ }"
  for domain_name in $normalized_domains; do
    for i in "${!domain_files[@]}"; do
      if [[ "${domain_files[$i]}" == "$domain_name" ]]; then
        selected_indices+=("$((i + 1))")
        break
      fi
    done
  done
  if [[ ${#selected_indices[@]} -eq 0 ]]; then
    error "PROMPT_HUB_DOMAINS='${PROMPT_HUB_DOMAINS}' matched no available domain files."
    exit 1
  fi
else
  echo ""
  echo -e "  ${BOLD}Available domains:${RESET}"
  for i in "${!domain_files[@]}"; do
    printf "    ${CYAN}%d)${RESET} %s\n" "$((i + 1))" "${domain_files[$i]}"
  done
  echo ""

  action_choice=""
  while true; do
    printf "  ${BOLD}Choose domain(s)${RESET} ${DIM}[1-${#domain_files[@]}, comma/space separated]${RESET}: "
    read -r action_choice
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
    warn "Invalid choice — enter numbers between 1 and ${#domain_files[@]}."
  done
fi

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
  error "Core file not found at ${CORE_FILE}."
  exit 1
fi

selected_domains_pattern="|"
for selected_domain_file in "${SELECTED_DOMAIN_FILES[@]}"; do
  selected_domains_pattern="${selected_domains_pattern}${selected_domain_file}|"
done

for domain_file in "${domain_files[@]}"; do
  if [[ "$selected_domains_pattern" != *"|$domain_file|"* ]]; then
    rm -f "$DOMAIN_DIR/$domain_file"
  fi
done

# ── Build agent files ─────────────────────────────────────────────────────────
step "Building agent files"

append_file_to_agents() {
  local file_path="$1"
  {
    cat "$file_path"
    echo ""
    echo ""
  } >> "$AGENT_FILE"
}

{
  echo "Version: $PROMPT_HUB_VERSION"
  echo ""
  if [[ -f "$TARGET_DIR/notice.md" ]]; then
    cat "$TARGET_DIR/notice.md"
    echo ""
  fi
  echo "# Agents"
  echo ""
  echo "Merged prompt content from app, core, and selected domain file(s)."
  echo ""
} > "$AGENT_FILE"

if [[ -d "$TARGET_APP_DIR" ]]; then
  while IFS= read -r app_file; do
    append_file_to_agents "$app_file"
  done < <(find "$TARGET_APP_DIR" -type f ! -iname "README.md" | sort)
fi

while IFS= read -r core_file; do
  append_file_to_agents "$core_file"
done < <(find "$TARGET_DIR/core" -type f | sort)

for selected_domain_file in "${SELECTED_DOMAIN_FILES[@]}"; do
  append_file_to_agents "$DOMAIN_DIR/$selected_domain_file"
done

selected_domains_display=""
for selected_domain_file in "${SELECTED_DOMAIN_FILES[@]}"; do
  if [[ -z "$selected_domains_display" ]]; then
    selected_domains_display="$selected_domain_file"
  else
    selected_domains_display="$selected_domains_display, $selected_domain_file"
  fi
done

cp "$AGENT_FILE" "$CLAUDE_FILE"

success "agents.md"
success "CLAUDE.md"
info   "Domains: ${BOLD}${selected_domains_display}${RESET}"

# ── Git commit ────────────────────────────────────────────────────────────────
if git -C "$PWD" rev-parse --is-inside-work-tree &>/dev/null; then
  step "Committing"
  git -C "$PWD" add \
    "$TARGET_DIR" \
    "$AGENT_FILE" \
    "$CLAUDE_FILE"
  if ! git -C "$PWD" diff --cached --quiet; then
    git -C "$PWD" commit -m "Install/update prompt-hub $PROMPT_HUB_VERSION (domains: $selected_domains_display)"
    success "Committed."
  else
    info "Nothing to commit (no changes detected)."
  fi
else
  info "Not a git repository — skipping commit."
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}  ✔ Prompt Hub v${PROMPT_HUB_VERSION} installed successfully!${RESET}"
echo ""
