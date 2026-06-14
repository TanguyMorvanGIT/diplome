# Diplôme — feed vidéo (style TikTok minimal)

Site statique pensé mobile (iPhone) : scroll vertical plein écran contrôlé par l'utilisateur (pas d'auto-scroll), son après un tap, chaque vidéo boucle sur elle-même. Boucle infinie : swipe vers le haut sur la dernière vidéo = retour à la première.

Interactions : tap pour pause/lecture, bouton son en haut à droite, barre de progression, gestion du notch (safe-area), anti pull-to-refresh, fenêtrage des vidéos pour éviter les écrans noirs.

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
