#!/usr/bin/env bash
# Régénère videos.json à partir des fichiers présents dans videos/
# Usage : ./update-videos.sh   (puis git add -A && git commit && git push)
cd "$(dirname "$0")"
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
