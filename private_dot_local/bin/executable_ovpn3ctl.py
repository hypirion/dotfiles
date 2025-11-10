#!/usr/bin/env python3
import argparse
import json
import os
import subprocess
import sys
from pathlib import Path


# A script to toggle a work VPN connection as well as give the current
# status on a waybar-compatible manner.
#
# This script assumes you have an openvpn3 profile named work, and
# that you have a file ~/.config/openvpn3/work.json with the format
#
# {
#   "username": "myusername",
#   "password": "mypassword"
# }



PROFILE_NAME = "work"
CREDS_PATH = Path(f"~/.config/openvpn3/{PROFILE_NAME}.json").expanduser()

def read_creds(path=CREDS_PATH):
    try:
        with open(path, "r", encoding="utf-8") as f:
            data = json.load(f)
        return data["username"], data["password"]
    except FileNotFoundError:
        sys.stderr.write(f"cred file not found: {path}\n")
    except KeyError as e:
        sys.stderr.write(f"missing key in cred file: {e}\n")
    except json.JSONDecodeError as e:
        sys.stderr.write(f"invalid JSON in cred file: {e}\n")
    sys.exit(2)

def run(cmd, **kwargs):
    return subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, **kwargs)

def list_sessions():
    # Returns list of session dicts: {"path": str, "config": str, "status": str}
    p = run(["openvpn3", "sessions-list"])
    if p.returncode != 0:
        return []
    sessions = []
    cur = {}
    for raw_line in p.stdout.splitlines():
        line = raw_line.strip()
        if line.startswith("Path:"):
            # new entry
            if 'path' in cur:
                sessions.append(cur)
                cur = {}
            cur["path"] = line.split("Path:", 1)[1].strip()
        elif line.startswith("Config name:"):
            cur["config"] = line.split("Config name:", 1)[1].strip()
        elif line.startswith("Status:"):
            cur["status"] = line.split("Status:", 1)[1].strip()
    if cur:
        sessions.append(cur)
    return sessions

def find_profile_session(profile=PROFILE_NAME):
    # Returns first matching session dict or None. Important to match
    # on session in case we mess up and end up with multiple sessions,
    # in which case we can't use --config to shut down the session.
    for s in list_sessions():
        if s.get("config") == profile:
            return s
    return None

def is_connected(profile=PROFILE_NAME):
    s = find_profile_session(profile)
    if not s:
        return False
    status = (s.get("status") or "").lower()
    # Treat "Connected" as connected. Ignore "Disconnected".
    return "connected" in status and "disconnected" not in status

def cmd_connect():
    if is_connected():
        return 0
    user, pwd = read_creds()
    # Feed username and password on stdin, each followed by newline
    proc = subprocess.run(
        ["openvpn3", "session-start", "--config", PROFILE_NAME],
        input=f"{user}\n{pwd}\n",
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if proc.returncode != 0:
        sys.stderr.write(proc.stderr or proc.stdout)
    return proc.returncode

def cmd_disconnect():
    s = find_profile_session()
    if not s:
        # Already disconnected
        return 0
    path = s.get("path")
    if not path:
        sys.stderr.write("could not find session path\n")
        return 3
    proc = run(["openvpn3", "session-manage", "--session-path", path, "--disconnect"])
    if proc.returncode != 0:
        sys.stderr.write(proc.stderr or proc.stdout)
    return proc.returncode

def cmd_toggle():
    if is_connected():
        return cmd_disconnect()
    return cmd_connect()

def cmd_status():
    obj = {}
    if is_connected():
        obj = {'text': 'Connected',
               'alt': 'connected',
               'class': ['connected'],
               'tooltip': 'Connected to work VPN',
               }
    else:
        obj = {'text': 'Disconnected',
               'alt': 'disconnected',
               'class': ['disconnected'],
               'tooltip': 'Not connected to work VPN',
               }
    print(json.dumps(obj))
    return 0

def main():
    parser = argparse.ArgumentParser(prog="ovpn3ctl", description="Manage openvpn3 work profile")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("connect")
    sub.add_parser("disconnect")
    sub.add_parser("toggle")
    sub.add_parser("status")

    args = parser.parse_args()

    if args.command == "connect":
        rc = cmd_connect()
    elif args.command == "disconnect":
        rc = cmd_disconnect()
    elif args.command == "toggle":
        rc = cmd_toggle()
    elif args.command == "status":
        rc = cmd_status()
    else:
        rc = 1

    sys.exit(rc)

if __name__ == "__main__":
    main()
