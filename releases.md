# Releases

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
