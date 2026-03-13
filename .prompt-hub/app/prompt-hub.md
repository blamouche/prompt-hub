# Prompt Hub App Rules

## Lesson-Driven Prompt Correction

Whenever a lesson is learned and written to `.prompt-hub/lessons.md`:

1. Identify which prompt file(s) in `prompt-library/` caused or allowed the mistake.
2. Update those files to add an explicit rule that prevents the issue from recurring.
3. The fix must be present in `prompt-library/` before the lesson is considered closed.

Skipping this step means the mistake will repeat for every agent that installs a future version. That is a failure.

## Version File Sync

- Every time `.prompt-hub/version.md` is updated, immediately copy it to `prompt-library/version.md`.
- If `prompt-library/version.md` does not exist, create it.
- Both files must always contain the same version string.
