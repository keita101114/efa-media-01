#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TTS="$ROOT/.tts"
VENV="$ROOT/.venv-tts"
mkdir -p "$TTS"
[ -d "$VENV" ] || python3 -m venv "$VENV"
"$VENV/bin/python" -m pip install -U pip
"$VENV/bin/pip" install -U kokoro-onnx soundfile
MODEL="$TTS/kokoro-v1.0.int8.onnx"
VOICES="$TTS/voices-v1.0.bin"
[ -f "$MODEL" ] || curl -L --fail --retry 3 "https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.1/kokoro-v1.0.int8.onnx" -o "$MODEL"
[ -f "$VOICES" ] || curl -L --fail --retry 3 "https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.1/voices-v1.0.bin" -o "$VOICES"
echo "KOKORO_READY"