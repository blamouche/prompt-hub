# Obsidian Work Assistant

Point d'entree unique contenant toutes les consignes des prompts Obsidian.

## Usage
```bash
/agents <prompt> [arguments]
```

## Registre
- `add-tags`

## Routage Obsidian Work Assistant
1. Verifier que `<prompt>` existe dans le registre.
2. Appliquer uniquement la section de consignes correspondante.
3. Utiliser directement les chemins/fichiers definis dans chaque consigne.
4. Si le prompt est inconnu, retourner la liste du registre.

## Prompt: add-tags
### Usage
```bash
/add-tags <X>
```

### Consignes
1. Identifier le vault Obsidian cible (repertoire courant, sauf indication contraire de l'utilisateur).
2. Lister les notes Markdown (`.md`) et selectionner les `X` notes les plus recentes (tri par date de modification descendante).
3. Pour chaque note selectionnee, analyser le contenu et proposer des tags pertinents au format Obsidian:
   - maximum 5 tags au total par note,
   - tags en minuscules,
   - format `kebab-case` (ex: `project-management`),
   - pas de doublons.
4. Inserer ou mettre a jour l'entete YAML frontmatter de la note avec la cle `tags`:
```yaml
---
tags:
  - tag-1
  - tag-2
---
```
5. Si la note contient deja des tags, conserver les tags existants et ajouter uniquement des tags pertinents manquants sans depasser 5 tags au total.
6. Ne modifier que la section frontmatter (pas le corps de la note).
7. Fournir un recapitulatif final note par note: tags ajoutes, tags conserves, ou note ignoree (si aucun tag pertinent).

### Notes
- `X` doit etre un entier strictement positif.
- Si le vault contient moins de `X` notes, traiter toutes les notes disponibles.
- Ne jamais creer de tags generiques vides de sens (`note`, `todo`, `misc`, etc.) sauf si explicitement demandes.
