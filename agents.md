# Agents

Merged prompt content from app, core, and selected domain file(s).

## Source: `./.prompt-hub/app/market-watch.md.sample`

# Market Watch App

```bash
# Dossiers
ROOT_DIR="."
AGENTS_DIR="agents"
SRC_DIR="src"
SYNTHESIS_DIR="synthesis"
RECAP_DIR="recap"

# Fichiers
README_FILE="README.md"
LIST_FILE="LIST.md"

# Patterns / templates
ARTICLE_FILE_TEMPLATE="$SRC_DIR/YYYY-MM/YYYYMMDD-<title-slug>.md"
MONTH_SYNTHESIS_TEMPLATE="$SYNTHESIS_DIR/YYYY-MM.md"
BATCH_RECAP_TEMPLATE="$SYNTHESIS_DIR/YYYY-MM-DD - HHmmss - batch recap.md"
WEEKLY_RECAP_TEMPLATE="$RECAP_DIR/YYYY-MM-DD-<theme-slug>.md"
```


## Source: `./.prompt-hub/app/market-watch.md.sample.bkp`

# Market Watch App

```bash
LIST_FILE="LIST.md"
```


## Source: `./.prompt-hub/core/core.md`

# Core Prompt

Use this prompt as the default operating policy for AI agents across all tasks and domains.

## Mission

- Deliver accurate, useful, and safe outcomes that match the user's intent.
- Prefer practical execution over theoretical discussion.
- Keep behavior consistent, traceable, and easy to review.

## Operating Rules

- Clarify the objective, constraints, and expected output before acting.
- If requirements are ambiguous, make the safest reasonable assumption and state it clearly.
- Break complex work into small, verifiable steps.
- Prioritize correctness, then reliability, then speed.
- Do not fabricate facts, results, files, or command outputs.
- If a requested action is impossible, explain why and propose the best alternative.

## Execution Standard

- Use existing project conventions before introducing new patterns.
- Make minimal, targeted changes that solve the problem end-to-end.
- Validate work with the strongest available checks (tests, linting, type checks, or manual verification).
- Surface risks, tradeoffs, and known limitations explicitly.
- Keep communication concise, direct, and actionable.

## Memory and Traceability

- Maintain a `memory.md` file.
- If `memory.md` does not exist, create it before logging any action.
- Log every meaningful AI-agent action with:
  - date and time,
  - actor (agent or tool),
  - action summary,
  - files changed or commands executed,
  - outcome status (`success`, `partial`, `failed`),
  - next relevant step (if any).
- Never delete historical entries; append new records in chronological order.

## Safety and Governance

- Respect security, privacy, and least-privilege principles.
- Never expose secrets, credentials, or sensitive user data.
- Flag potentially destructive operations before execution when possible.
- Follow applicable policy and legal constraints for the task context.

## Output Contract

- Ensure outputs are:
  - correct,
  - reproducible,
  - context-aware,
  - proportionate to the request.
- End with clear completion status and any required follow-up actions.


## Source: `./.prompt-hub/domain/app-development.md`

# App Development Prompt

Use this prompt for software application development tasks across web, mobile, backend, API, tooling, and automation projects.

## Mission

- Deliver production-ready, maintainable software aligned with user goals.
- Optimize for correctness, reliability, and clear handoff.
- Keep changes traceable, testable, and reversible.

## Scope and Clarification

- Identify the requested outcome, constraints, and success criteria before coding.
- State assumptions explicitly when requirements are incomplete.
- Prefer incremental delivery with verifiable checkpoints for large changes.

## Engineering Standards

- Reuse existing architecture, conventions, and dependency patterns when possible.
- Keep implementations simple, modular, and easy to review.
- Avoid unnecessary abstractions and speculative features.
- Preserve backward compatibility unless a breaking change is explicitly requested.

## Quality Requirements

- Add or update tests for any behavioral change.
- Run relevant validation steps (tests, linting, type checks, build) before completion.
- If validation cannot be executed, state what was not run and why.
- Include error handling, edge-case coverage, and sensible defaults.

## Security and Reliability

- Follow secure-by-default practices (input validation, output encoding, least privilege, secret safety).
- Never hardcode credentials, tokens, or sensitive data.
- Highlight risks for destructive operations or irreversible migrations.

## Versioning and Commits

- Maintain a 3-part version file named `version.md` using `X.X.X`.
- If `version.md` does not exist, create it before version updates.
- `X.0.0` is created only on explicit user request.
- `0.X.0` is created automatically when a new branch is created.
- `0.0.X` is incremented on every commit.
- Maintain a changelog file named `releases.md`; create it if it does not exist.
- For each version in `releases.md`, list the functional evolutions and/or fixes delivered.
- Each meaningful agent development action must result in a commit.
- After each commit, push the commit to the remote branch.
- Commit messages should be clear, scoped, and reflect the actual change.

## Documentation and Traceability

- Update technical documentation when behavior, APIs, setup, or architecture changes.
- Record key decisions, assumptions, and tradeoffs in concise notes.
- Ensure another engineer can understand what changed and why without extra context.

## Completion Contract

- Deliver:
  - what changed,
  - how it was validated,
  - known limitations or follow-up items.
- End with explicit status: `completed`, `partial`, or `blocked`.


## Source: `./.prompt-hub/domain/market-watch.md`

# Market Watch

Point d'entree unique contenant toutes les consignes des agents.

## Usage
```bash
/agents <agent> [arguments]
```

## Variables
```bash
# Dossiers
# ROOT_DIR="."
# AGENTS_DIR="agents"
# SRC_DIR="src"
# SYNTHESIS_DIR="synthesis"
# RECAP_DIR="recap"

# Fichiers
# README_FILE="README.md"
# LIST_FILE="LIST.md"

# Patterns / templates
# ARTICLE_FILE_TEMPLATE="$SRC_DIR/YYYY-MM/YYYYMMDD-<title-slug>.md"
# MONTH_SYNTHESIS_TEMPLATE="$SYNTHESIS_DIR/YYYY-MM.md"
# BATCH_RECAP_TEMPLATE="$SYNTHESIS_DIR/YYYY-MM-DD - HHmmss - batch recap.md"
# WEEKLY_RECAP_TEMPLATE="$RECAP_DIR/YYYY-MM-DD-<theme-slug>.md"
```

## Registre
- `article-synthesis`
- `add-url`
- `scan-list`
- `monthly-synthesis`
- `update-stats`
- `weekly-recap`

## Routage Market Watch
1. Verifier que `<agent>` existe dans le registre.
2. Appliquer uniquement la section de consignes correspondante.
3. Utiliser les variables de chemins/fichiers ci-dessus.
4. Si l'agent est inconnu, retourner la liste du registre.

## Agent: article-synthesis
### Usage
```bash
/article-synthesis <url>
```

### Consignes
1. Fetch article via WebFetch.
2. Extract metadata: Title, Date, Author, Keywords.
3. Create file at `$ARTICLE_FILE_TEMPLATE` (YYYYMMDD = date de publication si dispo, sinon date du jour):
```markdown
# [Title]
**Source**: [URL]
**Date**: [Date or "Unknown"]
**Author**: [Author or "Unknown"]
**Keywords**: [Inferred if needed]

## Elevator pitch
[One sentence summary]

## Takeaways
- [5 key points]

## Synthesis
[500-word synthesis: main arguments, insights, conclusions]
```
4. Update `$README_FILE`: add link under `## Articles > ### YYYY > #### Month` (newest first).
5. Run `/update-stats` to update statistics.
6. Commit and push:
   - `git fetch origin && git pull --rebase origin <branch>` if behind
   - Commit message: `Add synthesis: [Title]`

### Notes
- Create directories if needed.
- Maintain chronological order (newest first).
- Synthesis should be objective.

## Agent: add-url
### Usage
```bash
/add-url <url1> [url2] [url3] ...
```

### Consignes
1. Sync (must be clean):
   - `git status --porcelain` must be empty
   - `git pull --rebase`
2. Normalize + append URLs in `$LIST_FILE`:
   - Ensure file exists
   - One URL per line
   - Remove blank lines
   - De-duplicate exact duplicate URLs (preserve order)
3. Verify before committing:
   - `grep -Fqx -- "<url>" $LIST_FILE` for each URL intended.
4. Commit + push only if changes:
   - `git add $LIST_FILE`
   - if staged diff empty: stop
   - commit message: `Add URL(s) to processing queue`
5. Verify HEAD contains URLs:
   - `git show HEAD:$LIST_FILE | grep -Fqx -- "<url>"`

### Notes
- Avoid fragile shell escaping with URLs.
- Keep `$LIST_FILE` plain text, one URL per line.

## Agent: scan-list
### Usage
```bash
/scan-list
```

### Consignes
1. Open `$LIST_FILE` and note timestamp for batch recap.
2. For each URL (top to bottom, ignore empty lines):
   - Nettoyer l'URL (retirer `utm_*`, `ref`, `fbclid`, `gclid`, `mc_cid`, `mc_eid`, etc.)
   - Run `/article-synthesis <url-nettoyee>`
   - Extract title and elevator pitch from created file
   - Remove processed URL from `$LIST_FILE`
   - Commit: `Process article: [Title]`
3. Create batch recap at `$BATCH_RECAP_TEMPLATE`:
```markdown
# Batch Recap - YYYY-MM-DD HH:mm:ss

Article Title 1
Elevator pitch.
Synthese: https://url1

Article Title 2
Elevator pitch.
Synthese: https://url2
```
4. In recap:
   - Un bloc par article, separe par une ligne vide
   - `https://urlX` = lien GitHub vers la synthese (`blob/main/src/...`)
   - Ne pas inclure de tracking params
5. Commit recap: `Add batch recap: YYYY-MM-DD HHmmss`

### Notes
- Stop on error before modifying list.
- `$LIST_FILE` must be empty when complete.
- Use 24h format `HHmmss` for filename.

## Agent: monthly-synthesis
### Usage
```bash
/monthly-synthesis <YYYY-MM>
```

### Consignes
1. Read articles from `$SRC_DIR/YYYY-MM/` (stop if folder empty/missing).
2. Extract from each: Title, Source URL, Elevator pitch, Takeaways, Synthesis.
3. Consult previous syntheses (2-3 prior months).
4. Create `$MONTH_SYNTHESIS_TEMPLATE`:
```markdown
# Synthesis YYYY-MM

## Summary
[Up to 4 paragraphs on monthly trends in AI work and required adaptations]

## Selected links
- [Title](Source URL)
[15 links prioritizing AI work, enterprise usage, organization, skills]
```
5. Update `$README_FILE`: add synthesis link near month header.
6. Commit and push:
   - fetch/pull if behind
   - commit message: `Add monthly synthesis for YYYY-MM`

### Notes
- Write in English.
- Factual editorial style, max 4 paragraphs.
- Avoid hyperbolic words.
- ASCII filenames preferred.

## Agent: update-stats
### Usage
```bash
/update-stats
```

### Consignes
1. Parse `$README_FILE`: count articles per month (lines starting with `- [` under `#### Month`).
2. Generate statistics chart after title, before Articles section:
```text
## Statistics

Articles per month:

2026-01 | ████████ 46<br>
2026-02 | ██ 3
```
   - Each `█` = 3 articles (round up)
   - Chronological order (oldest first)
   - `<br>` after each line except last
   - Only months with articles
3. Update month headers: `#### January (5 articles)` (singular if 1).
4. Commit/push only when called directly (not from another agent):
   - fetch/pull if behind
   - commit message: `Update statistics`

### Notes
- Update existing Statistics section, do not duplicate.
- Preserve links and content.

## Agent: weekly-recap
### Usage
```bash
/weekly-recap <theme>
```

### Consignes
1. Calculate date range: today minus 7 days.
2. Scan articles in `$SRC_DIR/YYYY-MM/`:
   - Extract `**Date**` field (`Month DD, YYYY`)
   - Filter to last 7 days
3. Filter by theme using title, keywords, elevator pitch, synthesis.
4. Select up to 10 most relevant articles.
5. Create file at `$WEEKLY_RECAP_TEMPLATE`:
```markdown
[Executive summary: key insight and relevance to theme]

[Source URL]

---

[Next article...]
```
6. Commit and push:
   - fetch/pull if behind
   - commit message: `Add weekly recap: <theme>`

### Notes
- Strict 7-day filtering.
- Flexible theme matching.
- Original summaries only.
- Skip unparseable dates with warning.
- Report if no matching articles.


