# prompt-hub

## Quick Start

Run the command from the target directory (the directory where you want to generate `./.prompt-hub` and `./agents.md`):

### Installation

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

### Update

Run the exact same command again:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

### Important

- Never edit files inside `./.prompt-hub`.
- This directory is overwritten/rebuilt during updates.

Requirements:
- `bash`, `curl`, `tar`

This command:
- downloads the install script from GitHub
- runs the script in your current directory
- creates/updates `./.prompt-hub` and generates `./agents.md`

## Use the Local Install Script

The `install-prompt-hub.sh` script:
- retrieves `prompt-library` content and copies it into `./.prompt-hub`
- in `./.prompt-hub/app`, replaces only files ending with `.sample`
- before replacing `.sample` app files, backs up existing target `.sample` files with `.bkp` suffix
- asks which domain file(s) (`.md`) to use from `./.prompt-hub/domain`
- generates `./agents.md` by merging:
  - all files from `./.prompt-hub/app`
  - all files from `./.prompt-hub/core`
  - the selected file(s) from `./.prompt-hub/domain`
- removes non-selected domain files from local `./.prompt-hub/domain`
- warns during install when `.bkp` files are present in `./.prompt-hub/app`

### Requirements

- `bash`
- `curl`
- `tar`

### Run

```bash
chmod +x install-prompt-hub.sh
./install-prompt-hub.sh
```

Then choose one or more domain files from the list (for example: `app-development.md`).

### Expected Result

- local `./.prompt-hub` directory created/updated
- `./agents.md` file created at the root

### Option (Custom Archive URL)

By default, the script uses the GitHub archive from the main repository.
You can override the archive URL:

```bash
PROMPT_HUB_ARCHIVE_URL="https://..." ./install-prompt-hub.sh
```

You can also override repository/ref and authentication:

```bash
PROMPT_HUB_GITHUB_TOKEN="<your_github_token>" \
PROMPT_HUB_REPO="owner/private-repo" \
PROMPT_HUB_REF="main" \
./install-prompt-hub.sh
```

For private repositories, export a token with repository access before running the script:

```bash
export PROMPT_HUB_GITHUB_TOKEN="<your_github_token>"
```
