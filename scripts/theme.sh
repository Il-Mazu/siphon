# Siphon — ANSI palette
# Source from other scripts:  . "$(dirname "$0")/theme.sh"
#
# Roles (use these — never hardcode escapes elsewhere):
#   C_PRIMARY  dark violet brand
#   C_ACCENT   neon acid green
#   C_ERROR    blood red
#   C_WARN     amber / bruise yellow
#   C_SUCCESS  same family as accent (install OK)
#   C_MUTED    ash gray
#   C_TEXT     default readable body
#   C_BOLD / C_DIM / C_RESET
#
# Light vs dark: SIPHON_THEME=auto|dark|light  (default: auto)
# Disable: NO_COLOR=1  or non-TTY stdout

# Prevent double-init when sourced more than once
if [[ -n "${_SIPHON_THEME_LOADED:-}" ]]; then
  return 0 2>/dev/null || exit 0
fi
_SIPHON_THEME_LOADED=1

_siphon_theme_supported() {
  [[ -z "${NO_COLOR:-}" ]] || return 1
  [[ -t 1 ]] || return 1
  case "${TERM:-}" in
    dumb|"") return 1 ;;
  esac
  return 0
}

# auto → dark|light from COLORFGBG when available, else dark (CLI default)
_siphon_theme_mode() {
  local forced="${SIPHON_THEME:-auto}"
  case "$forced" in
    dark|light) printf '%s\n' "$forced"; return ;;
  esac
  # COLORFGBG=fg;bg  — higher bg indices are typically light
  local _bg_re='[^;]*;([0-9]+)$'
  if [[ "${COLORFGBG:-}" =~ $_bg_re ]]; then
    local bg="${BASH_REMATCH[1]}"
    if (( bg >= 7 && bg <= 15 )); then
      printf 'light\n'
      return
    fi
  fi
  printf 'dark\n'
}

_siphon_theme_apply() {
  C_RESET=''
  C_BOLD=''
  C_DIM=''
  C_PRIMARY=''
  C_ACCENT=''
  C_ERROR=''
  C_WARN=''
  C_SUCCESS=''
  C_MUTED=''
  C_TEXT=''

  if ! _siphon_theme_supported; then
    return 0
  fi

  local esc=$'\033'
  C_RESET="${esc}[0m"
  C_BOLD="${esc}[1m"
  C_DIM="${esc}[2m"

  local mode
  mode="$(_siphon_theme_mode)"

  if [[ "$mode" == light ]]; then
    # Deeper inks on pale backgrounds (still gothic, still readable)
    # purple #4A148C · blood #8B0000 · acid #1B7A1B · ash #4A4A4A
    C_PRIMARY="${esc}[38;2;74;20;140m"
    C_ACCENT="${esc}[38;2;27;122;27m"
    C_ERROR="${esc}[38;2;139;0;0m"
    C_WARN="${esc}[38;2;140;90;0m"
    C_SUCCESS="${esc}[38;2;27;122;27m"
    C_MUTED="${esc}[38;2;74;74;74m"
    C_TEXT="${esc}[38;2;26;26;26m"
  else
    # Brighter pigments on dark backgrounds
    # violet #B388FF · acid #B8FF26 · blood #FF2A4A · ash #9E9E9E
    C_PRIMARY="${esc}[38;2;179;136;255m"
    C_ACCENT="${esc}[38;2;184;255;38m"
    C_ERROR="${esc}[38;2;255;42;74m"
    C_WARN="${esc}[38;2;255;176;32m"
    C_SUCCESS="${esc}[38;2;184;255;38m"
    C_MUTED="${esc}[38;2;158;158;158m"
    C_TEXT="${esc}[38;2;232;232;232m"
  fi

  # 256-color fallbacks if truecolor unsupported (still dual-mode)
  if [[ "${COLORTERM:-}" != *truecolor* && "${COLORTERM:-}" != *24bit* ]]; then
    if [[ "$mode" == light ]]; then
      C_PRIMARY="${esc}[38;5;54m"    # deep purple
      C_ACCENT="${esc}[38;5;28m"     # dark green
      C_ERROR="${esc}[38;5;88m"      # dark red
      C_WARN="${esc}[38;5;130m"      # dark orange
      C_SUCCESS="${esc}[38;5;28m"
      C_MUTED="${esc}[38;5;240m"
      C_TEXT="${esc}[38;5;232m"
    else
      C_PRIMARY="${esc}[38;5;141m"   # soft violet
      C_ACCENT="${esc}[38;5;154m"    # acid green
      C_ERROR="${esc}[38;5;197m"     # blood/neon red
      C_WARN="${esc}[38;5;214m"
      C_SUCCESS="${esc}[38;5;154m"
      C_MUTED="${esc}[38;5;246m"
      C_TEXT="${esc}[38;5;252m"
    fi
  fi
}

_siphon_theme_apply

# Optional smoke preview:  bash scripts/theme.sh
if [[ "${BASH_SOURCE[0]-}" == "${0}" ]]; then
  printf '%sSiphon%s  %sprimary%s  %saccent%s  %serror%s  %swarn%s  %ssuccess%s  %smuted%s  %stext%s\n' \
    "${C_BOLD}${C_PRIMARY}" "$C_RESET" \
    "$C_PRIMARY" "$C_RESET" \
    "$C_ACCENT" "$C_RESET" \
    "$C_ERROR" "$C_RESET" \
    "$C_WARN" "$C_RESET" \
    "$C_SUCCESS" "$C_RESET" \
    "$C_MUTED" "$C_RESET" \
    "$C_TEXT" "$C_RESET"
  printf '%smode=%s  (override with SIPHON_THEME=dark|light|auto)%s\n' \
    "$C_MUTED" "$(_siphon_theme_mode)" "$C_RESET"
fi
