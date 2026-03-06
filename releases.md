# Releases

## 0.3.9 - 2026-03-06

- Functional evolution: updated `add-tags` prompt in `prompt-library/domain/obsidian-work-assistant.md` to exclude folders whose names start with `.` when scanning recent notes.
- Safety: added explicit restriction to never modify non-note files (technical files, prompt files, databases, config files, binaries, or any non-Markdown file).

## 0.3.8 - 2026-03-06

- Fix: adjusted installer output so generated `agents.md` starts with the version line as the first line of the file.
- Documentation: clarified in README that the version is written on the first line at the top of `agents.md`.

## 0.3.7 - 2026-03-06

- Functional evolution: installer now reads the current `version.md` value from the source package and prints it during installation.
- Functional evolution: generated `agents.md` now includes the current Prompt Hub version at the top of the file.
- Documentation: updated README installer behavior to mention version display and version header in `agents.md`.

## 0.3.6 - 2026-03-06

- Functional evolution: added explicit instruction in `prompt-library/domain/app-development.md` to update `README.md` when changes are relevant to existing README content.

## 0.3.5 - 2026-03-06

- Functional evolution: updated `add-tags` prompt in `prompt-library/domain/obsidian-work-assistant.md` to require English-only tags.
- Documentation: clarified that inferred tags must be normalized to English even when notes are written in another language.

## 0.3.4 - 2026-03-06

- Documentation: translated `prompt-library/domain/obsidian-work-assistant.md` from French to English.
- Functional evolution: kept the same `add-tags` behavior while clarifying all instructions in English.

## 0.3.3 - 2026-03-06

- Functional evolution: initialized `prompt-library/domain/obsidian-work-assistant.md` with a dedicated Obsidian prompt registry and routing section.
- Functional evolution: added prompt `add-tags` to scan the `X` most recent vault notes and update note frontmatter tags in Obsidian YAML format.
- Fix: constrained tag generation to relevant tags only, with a maximum of 5 tags per note and deduplication guidance.

## 0.3.2 - 2026-03-06

- Functional evolution: installer now merges all files from `prompt-library/app` into local `./.prompt-hub/app`, replacing files with identical relative paths.
- Fix: installer no longer creates `.bkp` backups for app files during install/update.
- Documentation: updated README app behavior to reflect merge-and-replace (same-name/path) without backups.

## 0.3.1 - 2026-03-06

- Fix: renamed domain file `prompt-library/domain/work-assistant.md` to `prompt-library/domain/obsidian-work-assistant.md`.

## 0.3.0 - 2026-03-06

- Functional evolution: created branch `domain/work-assistant` from `main`.
- Functional evolution: added new domain prompt file `prompt-library/domain/work-assistant.md`.

## 0.2.27 - 2026-03-05

- Fix: restored public-repository default installer behavior by switching default archive URL back to GitHub codeload (`https://codeload.github.com/...`).
- Fix: updated Quick Start commands to public no-token install/update flow using `bash <(curl -fsSL ...)`.
- Documentation: kept private-repository token usage as optional guidance.

## 0.2.26 - 2026-03-05

- Functional evolution: installer now supports private repository archive download through `PROMPT_HUB_GITHUB_TOKEN` (fallback to `GITHUB_TOKEN`).
- Functional evolution: installer now supports configurable private repo/ref via `PROMPT_HUB_REPO` and `PROMPT_HUB_REF`.
- Fix: installer now provides explicit auth guidance when archive download fails against private repositories.
- Fix: README updated with private repository install/update commands using authenticated script download.

## 0.2.25 - 2026-03-05

- Functional evolution: renamed Market Watch agent `substackpost` to `substack-post-recents`, including usage command `/substack-post-recents`.

## 0.2.24 - 2026-03-05

- Functional evolution: renamed Market Watch agent `monthly-substackpost` to `substack-post-monthly`, including usage command `/substack-post-monthly YYYY-MM`.

## 0.2.23 - 2026-03-05

- Functional evolution: added missing prompt sections in Market Watch for registry entries `monthly-substackpost`, `newsletter`, and `substackpost`.
- Functional evolution: aligned `agents.md` with the same added prompt sections for immediate local usage.

## 0.2.22 - 2026-03-05

- Functional evolution: reintroduced missing Market Watch registry entries in `prompt-library/domain/market-watch.md`: `monthly-substackpost`, `newsletter`, and `substackpost`.

## 0.2.21 - 2026-03-05

- Functional evolution: added a new root HTML page `hello.html` with a basic Hello World template.

## 0.2.20 - 2026-03-05

- Functional evolution: in `prompt-library/domain/market-watch.md`, removed the Variables section and inlined all previously variable-based paths/files directly in agent instructions.

## 0.2.19 - 2026-03-05

- Functional evolution: renamed Market Watch agent `weekly-recap-agent` to `weekly-recap`, including usage command `/weekly-recap <theme>`.

## 0.2.18 - 2026-03-05

- Functional evolution: renamed Market Watch agent `stats-agent` to `update-stats`, including usage command `/update-stats` and internal invocation references.

## 0.2.17 - 2026-03-05

- Functional evolution: renamed Market Watch agent `month-synthesis-agent` to `monthly-synthesis`, including usage command `/monthly-synthesis <YYYY-MM>`.

## 0.2.16 - 2026-03-05

- Functional evolution: renamed Market Watch agent `list-agent` to `scan-list`, including usage command `/scan-list`.

## 0.2.15 - 2026-03-05

- Functional evolution: renamed Market Watch agent `article-synthesis-agent` to `article-synthesis`, including usage command and internal invocation reference.

## 0.2.14 - 2026-03-05

- Functional evolution: renamed Market Watch agent `url-add` to `add-url`, including usage command `/add-url <url1> [url2] [url3] ...`.

## 0.2.13 - 2026-03-05

- Functional evolution: installer now updates `./.prompt-hub/app` by replacing only files ending with `.sample`.
- Fix: existing non-`.sample` files in `./.prompt-hub/app` are now preserved unchanged during install/upgrade.
- Fix: app backup behavior now applies to replaced `.sample` files only.
- Fix: updated README installer behavior description for `.sample`-only replacement in app.

## 0.2.12 - 2026-03-05

- Functional evolution: added `prompt-library/app/market-watch.md` with `LIST_FILE="LIST.md"` variable definition.

## 0.2.11 - 2026-03-05

- Functional evolution: installer now creates `.bkp` backups for existing files in `./.prompt-hub/app` before copying new app files.
- Functional evolution: installer now warns the user when backup files (`*.bkp`) are present in `./.prompt-hub/app`.
- Fix: updated README to document app backup and warning behavior during install/update.

## 0.2.10 - 2026-03-05

- Functional evolution: renamed Market Watch agent `list-add-agent` to `url-add`, including its usage command `/url-add <url1> [url2] [url3] ...`.

## 0.2.9 - 2026-03-05

- Fix: updated Market Watch entry command in usage from `/market-watch <agent> [arguments]` to `/agents <agent> [arguments]`.

## 0.2.8 - 2026-03-05

- Functional evolution: added a new root HTML test page `test.html`.

## 0.2.7 - 2026-03-05

- Functional evolution: installer now generates `agents.md` by merging the full content of local files from `./.prompt-hub/app`, `./.prompt-hub/core`, and selected domain files in `./.prompt-hub/domain`.
- Functional evolution: installer now removes non-selected domain files from local `./.prompt-hub/domain` after selection.
- Fix: updated README installer behavior description to match merged `agents.md` generation and local domain cleanup.

## 0.2.6 - 2026-03-05

- Functional evolution: changed installer output so `agents.md` now references selected core/domain prompt files instead of embedding full prompt contents.
- Fix: updated README installer behavior description to match reference-based `agents.md` generation.

## 0.2.5 - 2026-03-05

- Fix: removed Substack and Newsletter variables from `prompt-library/domain/market-watch.md`.

## 0.2.4 - 2026-03-05

- Functional evolution: removed `newsletter-agent` from `prompt-library/domain/market-watch.md`.

## 0.2.3 - 2026-03-05

- Functional evolution: removed `monthly-substackpost-agent` and `substackpost-agent` from `prompt-library/domain/market-watch.md`.

## 0.2.2 - 2026-03-05

- Fix: commented all variable assignment lines in `prompt-library/domain/market-watch.md` section `Variables`.

## 0.2.1 - 2026-03-05

- Fix: replaced remaining "Agent Global" references with "Market Watch" in `prompt-library/domain/market-watch.md`.

## 0.2.0 - 2026-03-05

- Functional evolution: initialized the `domain/market-watch` branch from `main` to start work on a dedicated Market Watch domain.

## 0.1.2 - 2026-03-05

- Functional evolution: translated `README.md` content from French to English while keeping the same structure and usage flow.

## 0.1.1 - 2026-03-05

- Functional evolution: clarified in Quick Start that the install/update command must be run from the target directory.

## 0.1.0 - 2026-03-05

- Functional evolution: added a Quick Start section at the top of `README.md` with install and update commands.
- Functional evolution: documented that `./.prompt-hub` must never be edited because updates overwrite its content.
- Fix: aligned documentation output filename to `agents.md` and reflected multi-domain selection.

## 0.0.7 - 2026-03-05

- Functional evolution: re-added `prompt-library/domain/test-domain.md` as a lightweight test domain.
