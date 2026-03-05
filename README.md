# prompt-hub

## Commande unique (repo public)

Depuis n'importe quel dossier local, lancez :

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/blamouche/prompt-hub/main/install-prompt-hub.sh)
```

Cette commande :
- télécharge le script d'installation depuis GitHub
- exécute le script dans votre dossier courant
- crée/met à jour `./.prompt-hub` puis génère `./agent.md`

Prérequis :
- `bash`, `curl`, `tar`

## Utiliser le script d'installation (local)

Le script `install-prompt-hub.sh` permet de :
- récupérer le contenu de `prompt-library` et le copier dans `./.prompt-hub`
- demander quel fichier de domaine (`.md`) utiliser dans `./.prompt-hub/domain`
- générer `./agent.md` en combinant `core/core.md` + le domaine sélectionné

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
- fichier `./agent.md` créé à la racine

### Option (URL d'archive personnalisée)

Par défaut, le script utilise l'archive GitHub du repo principal.
Vous pouvez surcharger l'URL :

```bash
PROMPT_HUB_ARCHIVE_URL="https://..." ./install-prompt-hub.sh
```
