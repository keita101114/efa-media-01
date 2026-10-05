#!/usr/bin/env python3
from pathlib import Path
import json
import soundfile as sf
from kokoro_onnx import Kokoro
ROOT=Path(__file__).resolve().parents[1]
EP=ROOT/'episodes/001'; OUT=ROOT/'output/001_kokoro'; OUT.mkdir(parents=True,exist_ok=True)
MODEL=ROOT/'.tts/kokoro-v1.0.int8.onnx'; VOICES=ROOT/'.tts/voices-v1.0.bin'
if not MODEL.exists() or not VOICES.exists(): raise SystemExit('Run automation/setup_kokoro_mac.command first.')
kokoro=Kokoro(str(MODEL),str(VOICES)); scenes=json.loads((EP/'storyboard.json').read_text(encoding='utf-8'))
for s in scenes:
    text=(s.get('narration') or s['on_screen_text']).strip()
    samples,sr=kokoro.create(text,voice='bm_george',speed=0.98,lang='en-gb')
    sf.write(OUT/f"{s['scene']:02d}.wav",samples,sr)
print('KOKORO_EP001_AUDIO_READY')
