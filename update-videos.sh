#!/usr/bin/env bash
# Régénère videos.json à partir des fichiers présents dans videos/
# et génère le poster (image fixe) manquant de chaque vidéo dans posters/.
# Le poster masque le noir pendant le décodage : sans lui -> sauts noirs.
# Usage : ./update-videos.sh   (puis git add -A && git commit && git push)
cd "$(dirname "$0")"

# --- Trouver un ffmpeg (PATH, puis binaire embarqué par imageio-ffmpeg) ---
FF="$(command -v ffmpeg 2>/dev/null)"
if [ -z "$FF" ]; then
  FF="$(python3 -c 'import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())' 2>/dev/null)"
fi
if [ -z "$FF" ]; then
  echo "ffmpeg introuvable -> posters non générés."
  echo "  Installe-le une fois : python3 -m pip install --user --break-system-packages imageio-ffmpeg"
fi

# --- Générer les posters manquants (1 image fixe par vidéo) ---
mkdir -p posters
if [ -n "$FF" ]; then
  for f in videos/*; do
    case "$f" in
      *.mp4|*.MP4|*.webm|*.WEBM|*.mov|*.MOV|*.m4v|*.M4V) ;;
      *) continue ;;
    esac
    base="$(basename "$f")"                 # ex: 09_video.mp4
    name="${base%.*}"                       # ex: 09_video
    name="${name%_video}"                   # ex: 09
    poster="posters/${name}.jpg"
    [ -f "$poster" ] && continue            # déjà présent -> on ne touche pas
    # Image à 1 s pour éviter les fondus noirs d'intro ; repli sur la 1re image.
    if ! "$FF" -y -loglevel error -ss 1 -i "$f" -frames:v 1 -q:v 3 "$poster" 2>/dev/null; then
      "$FF" -y -loglevel error -i "$f" -frames:v 1 -q:v 3 "$poster" 2>/dev/null
    fi
    [ -f "$poster" ] && echo "poster généré : $poster"
  done
fi

# --- Régénérer videos.json ---
{
  echo "["
  first=1
  for f in $(ls videos/ | grep -iE '\.(mp4|webm|mov|m4v)$' | sort); do
    [ $first -eq 0 ] && echo ","
    printf '  "videos/%s"' "$f"
    first=0
  done
  echo ""
  echo "]"
} > videos.json
echo "videos.json mis à jour :"
cat videos.json
