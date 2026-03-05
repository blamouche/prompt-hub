# prompt-hub

## Quick Start

Depuis le dossier cible (le dossier ou vous voulez generer `./.prompt-hub` et `./agents.md`) :

### Installation

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

### Mise a jour

Relancez exactement la meme commande :

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

### Important

- Ne modifiez jamais le contenu du dossier `./.prompt-hub`.
- Ce dossier est ecrase/reconstruit pendant les mises a jour.

Prérequis :
- `bash`, `curl`, `tar`

Cette commande :
- télécharge le script d'installation depuis GitHub
- exécute le script dans votre dossier courant
- crée/met à jour `./.prompt-hub` puis génère `./agents.md`

## Utiliser le script d'installation (local)

Le script `install-prompt-hub.sh` permet de :
- récupérer le contenu de `prompt-library` et le copier dans `./.prompt-hub`
- demander quel(s) fichier(s) de domaine (`.md`) utiliser dans `./.prompt-hub/domain`
- générer `./agents.md` en combinant `core/core.md` + le(s) domaine(s) sélectionné(s)

### Prérequis

- `bash`
- `curl`
- `tar`

### Exécution

```bash
chmod +x install-prompt-hub.sh
./install-prompt-hub.sh
```

Ensuite, choisissez le fichier de domaine proposé dans la liste (ex: `app-development.md`).

### Résultat attendu

- dossier local `./.prompt-hub` créé/mis à jour
- fichier `./agents.md` créé à la racine

### Option (URL d'archive personnalisée)

Par défaut, le script utilise l'archive GitHub du repo principal.
Vous pouvez surcharger l'URL :

```bash
PROMPT_HUB_ARCHIVE_URL="https://..." ./install-prompt-hub.sh
```
