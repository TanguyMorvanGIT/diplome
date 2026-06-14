# Diplôme — feed vidéo (style TikTok minimal)

Site statique : scroll vertical plein écran, son automatique après un tap, boucle infinie (après la dernière vidéo, retour à la première).

## Ajouter / changer des vidéos
1. Dépose tes fichiers `.mp4` dans le dossier `videos/`
2. Lance `./update-videos.sh` (régénère la liste `videos.json`)
3. Publie :
   ```
   git add -A
   git commit -m "maj videos"
   git push
   ```
GitHub Pages se met à jour tout seul en 1 à 2 minutes.

## Note
Les navigateurs interdisent le son au tout premier chargement. L'écran « Appuyer pour commencer » règle ça : un seul tap, puis tout joue avec le son automatiquement.
