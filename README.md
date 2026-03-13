# Prompt Hub

<p align="center">
  <img src="prompt-hub.png" alt="Prompt Hub" width="120" />
</p>

Prompt Hub is an AI agent prompt library and installer. It distributes a curated set of reusable prompts into any project directory, generating a single merged prompt file (`agents.md` / `CLAUDE.md`) that Claude Code and other AI agents read as their operating policy.

---

## Quick Start

Run from the target directory (where `.prompt-hub/` and `agents.md` will be created):

### Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

### Update

Run the same command again:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

**Requirements:** `bash`, `curl`, `tar`

---

## Architecture

### Source Repository Structure

```
prompt-library/
  version.md                    ← canonical Prompt Hub version string
  notice.md                     ← compliance notice + auto-update instructions
  core/
    core.md                     ← base operating policy (all agents)
  domain/
    app-development.md          ← domain prompt for software development
    market-watch.md             ← domain prompt for market monitoring
    obsidian-work-assistant.md  ← domain prompt for Obsidian workflows
    ...                         ← other domain-specific prompts
  app/
    README.md                   ← instructions for custom project prompts
install-prompt-hub.sh           ← installer / updater script
```

### Installed Project Structure

After running the installer, the target project contains:

```
.prompt-hub/
  notice.md             ← auto-update logic + compliance notice (replaced on update)
  core/
    core.md             ← base operating policy (replaced on update)
  domain/
    <selected>.md       ← only the domains you selected (replaced on update)
  app/
    README.md           ← custom prompt instructions (replaced from source)
    <your-custom>.md    ← your project-specific prompts (never touched)
  prompt-hub-version.md ← installed Prompt Hub version (written by installer)
  version.md            ← local repo version — user-owned, never overwritten
  releases.md           ← local changelog — user-owned, never overwritten
  memory.md             ← AI agent action log — user-owned, never overwritten
  .last-update-check    ← date of last auto-update check
agents.md               ← merged prompt file (regenerated on each install)
CLAUDE.md               ← identical copy of agents.md (Claude Code integration)
```

---

## Installation Process

The installer (`install-prompt-hub.sh`) runs the following steps:

### 1. Download

Downloads the `prompt-library` archive from GitHub (or uses a local fallback if the download fails):

```
https://codeload.github.com/blamouche/prompt-hub/tar.gz/refs/heads/main
```

Reads the Prompt Hub version from `prompt-library/version.md` inside the archive.

### 2. Install Files

Copies content from `prompt-library/` into `.prompt-hub/` using the following strategy:

| Source path | Target path | Strategy |
|---|---|---|
| `notice.md` | `.prompt-hub/notice.md` | Replaced entirely |
| `core/` | `.prompt-hub/core/` | Replaced entirely |
| `domain/` | `.prompt-hub/domain/` | Replaced entirely |
| `app/` | `.prompt-hub/app/` | Merged — source files copied, user custom files preserved |
| — | `.prompt-hub/version.md` | Never touched (user-owned) |
| — | `.prompt-hub/releases.md` | Never touched (user-owned) |
| — | `.prompt-hub/memory.md` | Never touched (user-owned) |

The installed Prompt Hub version is written to `.prompt-hub/prompt-hub-version.md` for the auto-update check to compare against.

**Legacy migration:** if `version.md`, `releases.md`, or `memory.md` exist at the project root (from older installs), they are migrated to `.prompt-hub/` automatically.

### 3. Domain Selection

The installer lists all available domain files from `.prompt-hub/domain/` and prompts you to choose one or more.

Non-selected domain files are deleted from `.prompt-hub/domain/`.

**Non-interactive mode** (CI, auto-update): set `PROMPT_HUB_DOMAINS` to skip the prompt:

```bash
PROMPT_HUB_DOMAINS="app-development.md" bash <(curl -fsSL ...)
# Multiple domains:
PROMPT_HUB_DOMAINS="app-development.md,market-watch.md" bash <(curl -fsSL ...)
```

### 4. Build Agent Files

Generates `agents.md` (and an identical `CLAUDE.md`) by concatenating:

1. Version header: `Version: X.X.X`
2. Contents of `.prompt-hub/notice.md`
3. `# Agents` section header
4. All files from `.prompt-hub/app/` (except README.md)
5. All files from `.prompt-hub/core/`
6. The selected domain file(s) from `.prompt-hub/domain/`

This single merged file is what AI agents load as their operating policy.

### 5. Git Commit

If the target directory is a git repository, the installer automatically stages and commits `.prompt-hub/`, `agents.md`, and `CLAUDE.md` with a message like:

```
Install/update prompt-hub 0.4.0 (domains: app-development.md)
```

---

## Auto-Update Logic

The auto-update check is embedded inside `notice.md`, which is included in every generated `CLAUDE.md`. Claude Code reads this file at every session start and follows these instructions automatically:

1. **Check last run:** read `.prompt-hub/.last-update-check`. If it contains today's date (`YYYY-MM-DD`), skip — already checked today.
2. **Write today's date** to `.prompt-hub/.last-update-check`.
3. **Fetch remote version:** `curl https://raw.githubusercontent.com/blamouche/prompt-hub/main/prompt-library/version.md`
   - If the fetch fails (no network, private repo), stop silently.
4. **Compare** the fetched version to `.prompt-hub/prompt-hub-version.md`.
   - If remote ≤ installed, stop silently.
5. **Run a silent update:** re-run the installer in non-interactive mode, passing the currently installed domain filenames via `PROMPT_HUB_DOMAINS`.
6. **Notify the user:** "Prompt Hub updated from X.X.X to Y.Y.Y." and log the action to `.prompt-hub/memory.md`.

This means: as long as an AI agent (Claude Code) is active in the project, it will silently keep Prompt Hub up to date once per day.

---

## Custom Project Prompts

Place your own `.md` prompt files in `.prompt-hub/app/`. They are:
- **Never overwritten or deleted** during updates.
- **Automatically merged** into `agents.md` on every install.

After adding or editing a custom prompt, re-run the installer to regenerate `agents.md`.

See [.prompt-hub/app/README.md](.prompt-hub/app/README.md) for details.

---

## Configuration

### Private Repository

```bash
PROMPT_HUB_GITHUB_TOKEN="<your_token>" \
PROMPT_HUB_REPO="owner/private-repo" \
PROMPT_HUB_REF="main" \
bash <(curl -fsSL ...)
```

Or export the token before running:

```bash
export PROMPT_HUB_GITHUB_TOKEN="<your_token>"
bash <(curl -fsSL ...)
```

### Custom Archive URL

```bash
PROMPT_HUB_ARCHIVE_URL="https://..." ./install-prompt-hub.sh
```

---

## User-Owned Files

These files in `.prompt-hub/` belong to your project and are **never overwritten** by the installer or auto-update:

| File | Purpose |
|---|---|
| `version.md` | Local repo version (`X.X.X`) — increment per commit |
| `releases.md` | Changelog — one entry per version |
| `memory.md` | AI agent action log — append-only |
| `app/<custom>.md` | Your project-specific prompt files |

Do not manually edit `notice.md`, `core/`, or `domain/` — these are replaced on every update.
