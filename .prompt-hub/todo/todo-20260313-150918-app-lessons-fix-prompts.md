# Task: Add rule to fix prompt-library prompts after every lesson learned

## Objective

Update `.prompt-hub/app/prompt-hub.md` to mandate that whenever a lesson is learned and written to `lessons.md`, the agent must also correct the relevant prompt files in `prompt-library/` to prevent the issue from recurring.

## Steps

- [x] Create this task file
- [x] Update `.prompt-hub/app/prompt-hub.md` with the new rule
- [x] Bump version to 0.4.6
- [x] Update releases.md and sync prompt-library/version.md
- [x] Commit and push

## Review

- **What changed:** Added "Lesson-Driven Prompt Correction" section to `.prompt-hub/app/prompt-hub.md` — mandates identifying and fixing the root `prompt-library/` file(s) after every lesson, before the lesson is closed.
- **Validated:** Committed and pushed to `main` (ffafd83).
- **Status:** completed
