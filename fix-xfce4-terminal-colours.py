#!/usr/bin/env python3

from pathlib import Path
import os
from datetime import datetime

basepath = Path.home() / ".config" / "xfce4" / "terminal"

light = basepath / "terminalrc-light"
dark = basepath / "terminalrc-dark"
cur = basepath / "terminalrc"

t = datetime.now()

target = dark
if 7 <= t.hour <= 19:
    target = light

target_bytes = target.read_bytes()

if cur.read_bytes() != target_bytes:
    cur.write_bytes(target_bytes)
