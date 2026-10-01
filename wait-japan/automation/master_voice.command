#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IN="$ROOT/output/001_kokoro"; OUT="$ROOT/output/001_mastered"; mkdir -p "$OUT"
for f in "$IN"/*.wav; do
  [ -e "$f" ] || continue
  ffmpeg -y -hide_banner -loglevel error -i "$f" -af "highpass=f=70,lowpass=f=15500,acompressor=threshold=-18dB:ratio=2.2:attack=15:release=180,loudnorm=I=-16:TP=-1.5:LRA=7" "$OUT/$(basename "$f")"
done
echo "MASTERED_AUDIO_READY"
