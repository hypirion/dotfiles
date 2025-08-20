#!/usr/bin/env python3

import sys
import os
import subprocess
from pathlib import Path

def env_path_or_default(var, default):
    if (value := os.environ.get(var)) and (path := Path(value)).is_absolute():
        return path
    return default

xdg_config_home = env_path_or_default("XDG_CONFIG_HOME",
                                      Path.home() / ".config")

## TODO: Implement time detection here. Should be straightforward.

def set_alacritty(theme):
    dir = xdg_config_home / "alacritty"
    base = dir / "alacritty-base.toml"
    colours = dir / f"alacritty-{theme}.toml"
    data = base.read_text() + '\n' + colours.read_text()
    config_file = dir / "alacritty.toml"
    config_file.write_text(data)

def set_gnome(theme):
    pref = '"prefer-dark"'
    if theme == 'light':
        pref = '"prefer-light"'
    subprocess.run(['dconf', 'write', '/org/gnome/desktop/interface/color-scheme', pref])

def set_theme(theme):
    set_alacritty(theme)
    set_gnome(theme)

if __name__ == '__main__':
    if len(sys.argv) != 2 or sys.argv[1] not in {'dark', 'light', 'by-time'}:
        print(f'usage: {sys.argv[0]} dark|light|by-time')
        print()
        print('when by-time is passed in, it will be set to a dark theme between 20:00 and 06:00')
        sys.exit(1)
    theme = sys.argv[1]
    set_theme(theme)

