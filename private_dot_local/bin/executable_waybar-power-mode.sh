#!/usr/bin/env bash
set -euo pipefail

ppc="$(command -v powerprofilesctl || true)"
if [[ -z "$ppc" ]]; then
  echo '{"text":"N/A","icon":"","class":["power","error"],"tooltip":"powerprofilesctl not found"}'
  exit 0
fi

get_mode() { powerprofilesctl get 2>/dev/null || echo "unknown"; }
set_mode() { powerprofilesctl set "$1" >/dev/null 2>&1; }

case "${1:-print}" in
  toggle)
    cur="$(get_mode)"
    case "$cur" in
      performance) next="balanced" ;;
      balanced) next="power-saver" ;;
      power-saver|power_saver) next="performance" ;;
      *) next="balanced" ;;
    esac
    set_mode "$next"
    ;;
  performance|balanced|power-saver) set_mode "$1" ;;
  *) : ;; # print
esac

mode="$(get_mode)"
case "$mode" in
  performance) icon=""; name="Performance"; klass="performance" ;;
  balanced)    icon=""; name="Balanced";    klass="balanced" ;;
  power-saver|power_saver) icon=""; name="Eco"; klass="eco" ;;
  *)           icon=""; name="Unknown";     klass="unknown" ;;
esac

printf '{"text":"%s","alt":"%s","class":["power","%s"],"tooltip":"Power mode: %s"}\n' \
       "$name" "$klass" "$klass" "$name"
