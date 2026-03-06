# Memory Log

- date_time: 2026-03-05 11:05:27 CET
  actor: agent
  action_summary: Added a new Hello World HTML page and initialized project traceability files.
  files_changed: hello.html, version.md, memory.md
  commands_executed: cat > hello.html, cat > version.md, cat > memory.md
  outcome_status: success
  next_relevant_step: Stage files and create commit.

- date_time: 2026-03-05 11:09:53 CET
  actor: agent
  action_summary: Updated the app-development prompt to require pushing after each commit and bumped patch version.
  files_changed: prompt-library/domain/app-development.md, version.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage and commit the documentation/version updates.

- date_time: 2026-03-05 11:18:10 CET
  actor: agent
  action_summary: Updated installer update behavior to replace core/domain and merge app by filename, then bumped patch version.
  files_changed: install-prompt-hub.sh, version.md, memory.md
  commands_executed: apply_patch, bash -n install-prompt-hub.sh
  outcome_status: success
  next_relevant_step: Stage, commit, and push the installer changes.

- date_time: 2026-03-05 13:37:31 CET
  actor: agent
  action_summary: Added multi-domain selection support to installer and created a test domain file, then validated interactive multi-select flow.
  files_changed: install-prompt-hub.sh, prompt-library/domain/test-domain.md, version.md, memory.md
  commands_executed: apply_patch, bash -n install-prompt-hub.sh, printf '1 2\n' | PROMPT_HUB_ARCHIVE_URL='http://127.0.0.1:9/nope' bash install-prompt-hub.sh
  outcome_status: success
  next_relevant_step: Stage, commit, and push the installer and prompt-library updates.

- date_time: 2026-03-05 13:38:22 CET
  actor: agent
  action_summary: Updated app-development prompt to require creating and maintaining releases.md entries per version, then bumped patch version.
  files_changed: prompt-library/domain/app-development.md, version.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push prompt and versioning updates.

- date_time: 2026-03-05 13:42:16 CET
  actor: agent
  action_summary: Removed the temporary test domain file from prompt-library and bumped patch version.
  files_changed: prompt-library/domain/test-domain.md, version.md, memory.md
  commands_executed: apply_patch, bash -n install-prompt-hub.sh
  outcome_status: success
  next_relevant_step: Stage, commit, and push domain cleanup updates.

- date_time: 2026-03-05 13:44:00 CET
  actor: agent
  action_summary: Created a new test domain prompt and initialized releases.md with the corresponding release note, then bumped patch version.
  files_changed: prompt-library/domain/test-domain.md, releases.md, version.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push domain creation updates.

- date_time: 2026-03-05 13:50:23 CET
  actor: agent
  action_summary: Created a documentation branch and reinforced README with Quick Start install/update and .prompt-hub overwrite warning; aligned generated filename references and updated release/version metadata.
  files_changed: README.md, releases.md, version.md, memory.md
  commands_executed: git checkout -b docs/quick-start-update, apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the documentation updates branch.

- date_time: 2026-03-05 13:53:17 CET
  actor: agent
  action_summary: Clarified in Quick Start that install/update must be run from the target directory, then updated release and version tracking.
  files_changed: README.md, releases.md, version.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the documentation clarification.

- date_time: 2026-03-05 13:54:20 CET
  actor: agent
  action_summary: Translated README documentation from French to English and updated release/version tracking.
  files_changed: README.md, releases.md, version.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the README translation update.

- date_time: 2026-03-05 14:08:15 CET
  actor: agent
  action_summary: Created branch `domain/market-watch` from `main` (keeping existing local modifications) and initialized branch-level version/release tracking.
  files_changed: version.md, releases.md, memory.md
  commands_executed: git checkout -b domain/market-watch, apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push branch initialization metadata.

- date_time: 2026-03-05 14:29:28 CET
  actor: agent
  action_summary: Replaced "Agent Global" naming with "Market Watch" in the market-watch domain prompt and updated traceability/version files.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the Market Watch wording update.

- date_time: 2026-03-05 14:30:35 CET
  actor: agent
  action_summary: Commented all variables in the Market Watch prompt variables block and updated versioning traceability files.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the variables comment update.

- date_time: 2026-03-05 14:32:28 CET
  actor: agent
  action_summary: Removed monthly and standard substack post agents from the Market Watch prompt and updated versioning traceability files.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the agent removal update.

- date_time: 2026-03-05 14:33:14 CET
  actor: agent
  action_summary: Removed newsletter agent from the Market Watch prompt and updated versioning traceability files.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the newsletter agent removal.

- date_time: 2026-03-05 14:34:12 CET
  actor: agent
  action_summary: Removed Substack and Newsletter variable lines from the Market Watch variables block and updated versioning traceability files.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: apply_patch
  outcome_status: success
  next_relevant_step: Stage, commit, and push the variable cleanup update.

- date_time: 2026-03-05 14:37:19 CET
  actor: agent
  action_summary: Updated installer to generate agents.md with references to core/domain selected prompts instead of merged prompt content, and aligned README behavior description.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: apply_patch, bash -n install-prompt-hub.sh, printf '1\n' | bash ./install-prompt-hub.sh (in temp directory)
  outcome_status: success
  next_relevant_step: Stage, commit, and push installer behavior update.

- date_time: 2026-03-05 14:42:35 CET
  actor: agent
  action_summary: Loaded and aligned behavior to repository agent prompts from agents.md (core and app-development).
  files_changed: memory.md
  commands_executed: cat ./.prompt-hub/core/core.md, cat ./.prompt-hub/domain/app-development.md, tail -n 80 memory.md
  outcome_status: success
  next_relevant_step: Apply these prompt policies to all subsequent tasks in this repository.

- date_time: 2026-03-05 14:43:22 CET
  actor: agent
  action_summary: Created a new HTML test page.
  files_changed: test.html, memory.md
  commands_executed: rg --files -g '*.html', cat > test.html
  outcome_status: success
  next_relevant_step: Open test.html in a browser to verify rendering.

- date_time: 2026-03-05 14:44:39 CET
  actor: agent
  action_summary: Removed all HTML files from the repository.
  files_changed: hello.html, hello-world.html, news.html, test.html, memory.md
  commands_executed: find . -type f -name '*.html' | sort, find . -type f -name '*.html' -delete
  outcome_status: success
  next_relevant_step: Recreate any required HTML entrypoints if needed.

- date_time: 2026-03-05 14:54:24 CET
  actor: agent
  action_summary: Updated installer to merge app/core/selected-domain file contents into agents.md and delete non-selected local domain files; aligned README and versioning records.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: ls -la .prompt-hub, find .prompt-hub -maxdepth 3 -type f, sed -n on install-prompt-hub.sh, rg -n on README.md, apply_patch, bash -n install-prompt-hub.sh, local installer smoke test with fallback archive URL
  outcome_status: success
  next_relevant_step: Stage, commit, and push installer behavior update.

- date_time: 2026-03-05 14:58:02 CET
  actor: agent
  action_summary: Added a new root HTML test file and updated version/release tracking.
  files_changed: test.html, version.md, releases.md, memory.md
  commands_executed: cat > test.html, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the new test HTML page.

- date_time: 2026-03-05 15:00:07 CET
  actor: agent
  action_summary: Updated Market Watch usage command from /market-watch to /agents and updated version/release tracking.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the Market Watch command update.

- date_time: 2026-03-05 15:02:37 CET
  actor: agent
  action_summary: Renamed Market Watch agent list-add-agent to url-add and updated usage command.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: rg -n list-add-agent, apply_patch, rg -n verification, date
  outcome_status: success
  next_relevant_step: Commit and push the agent rename update.

- date_time: 2026-03-05 15:09:26 CET
  actor: agent
  action_summary: Added app-file backup behavior during installer updates (.bkp), added warning when backups exist, and aligned README/versioning.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: nl -ba install-prompt-hub.sh, apply_patch, bash -n install-prompt-hub.sh, local installer backup smoke test, date
  outcome_status: success
  next_relevant_step: Commit and push installer backup behavior update.

- date_time: 2026-03-05 15:14:09 CET
  actor: agent
  action_summary: Added app-level Market Watch prompt file with LIST_FILE variable and updated versioning records.
  files_changed: prompt-library/app/market-watch.md, version.md, releases.md, memory.md
  commands_executed: ls -la prompt-library, ls -la .prompt-hub, cat > prompt-library/app/market-watch.md, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the new app file.

- date_time: 2026-03-05 15:23:16 CET
  actor: agent
  action_summary: Updated installer app-sync strategy to replace only .sample files, preserve non-.sample local app files, and keep backup/warning behavior scoped to replaced .sample files.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: nl -ba install-prompt-hub.sh, nl -ba README.md, apply_patch, bash -n install-prompt-hub.sh, local sample-only installer smoke test, date
  outcome_status: success
  next_relevant_step: Commit and push the app .sample replacement behavior update.

- date_time: 2026-03-05 15:28:36 CET
  actor: agent
  action_summary: Renamed Market Watch agent url-add to add-url in source domain prompt and generated agents.md.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n url-add, apply_patch, rg -n verification, date
  outcome_status: success
  next_relevant_step: Commit and push the add-url rename update.

- date_time: 2026-03-05 15:49:17 CET
  actor: agent
  action_summary: Renamed Market Watch agent article-synthesis-agent to article-synthesis in domain prompt (registry, usage, and internal call reference).
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: rg -n article-synthesis-agent, apply_patch, rg -n verification, date
  outcome_status: success
  next_relevant_step: Commit and push the article-synthesis rename update.

- date_time: 2026-03-05 15:53:11 CET
  actor: agent
  action_summary: Renamed Market Watch agent list-agent to scan-list in source domain prompt and generated agents.md.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n list-agent, perl in-place replacement, rg -n verification, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the scan-list rename update.

- date_time: 2026-03-05 15:59:47 CET
  actor: agent
  action_summary: Renamed Market Watch agent month-synthesis-agent to monthly-synthesis in source domain prompt and generated agents.md.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n month-synthesis-agent, perl in-place replacement, rg -n verification, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the monthly-synthesis rename update.

- date_time: 2026-03-05 16:04:17 CET
  actor: agent
  action_summary: Renamed Market Watch agent stats-agent to update-stats in source domain prompt and generated agents.md, including command references.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n stats-agent, perl in-place replacement, rg -n verification, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the update-stats rename update.

- date_time: 2026-03-05 16:05:53 CET
  actor: agent
  action_summary: Renamed Market Watch agent weekly-recap-agent to weekly-recap in source domain prompt and generated agents.md.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n weekly-recap-agent, perl in-place replacement, rg -n verification, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the weekly-recap rename update.

- date_time: 2026-03-05 16:40:22 CET
  actor: agent
  action_summary: Removed Variables section from Market Watch domain prompt and hardcoded path/file references directly in instructions.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: nl -ba prompt-library/domain/market-watch.md, rg -n variable references, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the hardcoded path/file update.

- date_time: 2026-03-05 16:46:50 CET
  actor: agent
  action_summary: Created a root Hello World HTML file and updated version/release tracking.
  files_changed: hello.html, version.md, releases.md, memory.md
  commands_executed: rg --files -g '*.html', cat > hello.html, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the new HTML file.

- date_time: 2026-03-05 16:51:39 CET
  actor: agent
  action_summary: Reintroduced missing Market Watch registry entries from provided reference code.
  files_changed: prompt-library/domain/market-watch.md, version.md, releases.md, memory.md
  commands_executed: nl -ba prompt-library/domain/market-watch.md, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push registry completion update.

- date_time: 2026-03-05 17:14:40 CET
  actor: agent
  action_summary: Added missing Market Watch prompt sections matching newly restored registry entries (monthly-substackpost, newsletter, substackpost) and aligned agents.md.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n checks on market-watch.md and agents.md, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push missing prompt sections update.

- date_time: 2026-03-05 17:31:07 CET
  actor: agent
  action_summary: Renamed monthly-substackpost agent to substack-post-monthly in Market Watch prompts.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n monthly-substackpost, perl in-place replacement, rg -n verification, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the substack-post-monthly rename update.

- date_time: 2026-03-05 17:34:19 CET
  actor: agent
  action_summary: Renamed substackpost agent to substack-post-recents in Market Watch prompts.
  files_changed: prompt-library/domain/market-watch.md, agents.md, version.md, releases.md, memory.md
  commands_executed: rg -n substackpost, perl in-place replacement, rg -n verification, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the substack-post-recents rename update.

- date_time: 2026-03-05 21:23:41 CET
  actor: agent
  action_summary: Updated installer and README to support private repository installation via GitHub token authentication and configurable repo/ref.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: sed -n install-prompt-hub.sh, sed -n README.md, apply_patch, bash -n install-prompt-hub.sh, local installer fallback smoke test, date
  outcome_status: success
  next_relevant_step: Commit and push private-repo install support update.

- date_time: 2026-03-05 21:41:33 CET
  actor: agent
  action_summary: Updated installer back to public-by-default download flow and aligned README quick start while keeping private token usage optional.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: sed -n install-prompt-hub.sh, sed -n README.md, apply_patch, bash -n install-prompt-hub.sh, local installer fallback smoke test, date
  outcome_status: success
  next_relevant_step: Commit and push public install flow update.

- date_time: 2026-03-06 12:29:31 CET
  actor: agent
  action_summary: Created branch domain/work-assistant from main, added new Work Assistant domain prompt, and initialized branch-level version/release metadata.
  files_changed: prompt-library/domain/work-assistant.md, version.md, releases.md, memory.md
  commands_executed: git checkout -b domain/work-assistant, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the new branch with domain initialization.

- date_time: 2026-03-06 12:32:55 CET
  actor: agent
  action_summary: Renamed new work assistant domain file to obsidian-work-assistant and updated branch versioning metadata.
  files_changed: prompt-library/domain/obsidian-work-assistant.md, prompt-library/domain/work-assistant.md, version.md, releases.md, memory.md
  commands_executed: mv prompt-library/domain/work-assistant.md prompt-library/domain/obsidian-work-assistant.md, apply_patch, date
  outcome_status: success
  next_relevant_step: Commit and push the domain filename rename.

- date_time: 2026-03-06 15:11:10 CET
  actor: agent
  action_summary: Replaced specific project/tool example content in the Obsidian work assistant prompt with generic, neutral example text.
  files_changed: prompt-library/domain/obsidian-work-assistant.md, memory.md
  commands_executed: sed -n prompt-library/domain/obsidian-work-assistant.md, apply_patch, tail -n memory.md, date
  outcome_status: success
  next_relevant_step: Commit and push the generic example wording update.

- date_time: 2026-03-06 15:23:25 CET
  actor: agent
  action_summary: Updated installer app sync behavior to merge source app files by identical path/name without backups, and aligned README/versioning records.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: sed -n README.md and install-prompt-hub.sh, apply_patch, bash -n install-prompt-hub.sh, local installer merge smoke test, date
  outcome_status: success
  next_relevant_step: Commit and push app merge-without-backup installer update.

- date_time: 2026-03-06 15:38:03 CET
  actor: agent
  action_summary: Initialized Obsidian work assistant domain file and added new prompt `add-tags` to scan the X latest vault notes and update Obsidian frontmatter tags (max 5 per note).
  files_changed: prompt-library/domain/obsidian-work-assistant.md, memory.md
  commands_executed: wc/cat inspection, cat heredoc write for domain file, date
  outcome_status: success
  next_relevant_step: Commit and push the new Obsidian `add-tags` prompt.

- date_time: 2026-03-06 15:38:31 CET
  actor: agent
  action_summary: Bumped patch version and added release note entry for the new Obsidian `add-tags` domain prompt.
  files_changed: version.md, releases.md, memory.md
  commands_executed: apply_patch version.md, apply_patch releases.md, date
  outcome_status: success
  next_relevant_step: Commit and push version/release traceability updates.

- date_time: 2026-03-06 15:40:12 CET
  actor: agent
  action_summary: Translated the Obsidian work assistant prompt content from French to English while preserving `add-tags` behavior.
  files_changed: prompt-library/domain/obsidian-work-assistant.md, version.md, releases.md, memory.md
  commands_executed: apply_patch translation, apply_patch version.md, apply_patch releases.md, date
  outcome_status: success
  next_relevant_step: Commit and push the English translation update.

- date_time: 2026-03-06 15:40:47 CET
  actor: agent
  action_summary: Updated Obsidian `add-tags` prompt to enforce English-only tags and added explicit English normalization note.
  files_changed: prompt-library/domain/obsidian-work-assistant.md, version.md, releases.md, memory.md
  commands_executed: apply_patch prompt update, apply_patch version.md, apply_patch releases.md, date
  outcome_status: success
  next_relevant_step: Commit and push the English-tags requirement update.

- date_time: 2026-03-06 15:48:31 CET
  actor: agent
  action_summary: Updated app development domain prompt to require README updates when changes are relevant to existing README content.
  files_changed: prompt-library/domain/app-development.md, version.md, releases.md, memory.md
  commands_executed: apply_patch app-development.md, apply_patch version.md, apply_patch releases.md, date
  outcome_status: success
  next_relevant_step: Commit and push the app-development README instruction update.

- date_time: 2026-03-06 15:51:26 CET
  actor: agent
  action_summary: Updated installer to display current Prompt Hub version during install and include version header at top of generated agents.md.
  files_changed: install-prompt-hub.sh, README.md, version.md, releases.md, memory.md
  commands_executed: apply_patch install script, apply_patch README, bash -n install-prompt-hub.sh, isolated tmp install smoke test with domain selection, apply_patch version.md, apply_patch releases.md, date
  outcome_status: success
  next_relevant_step: Commit and push installer version display/header updates.
