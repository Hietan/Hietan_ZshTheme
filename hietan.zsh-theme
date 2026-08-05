#
# Hietan Zsh Theme
# Version: 1.1.1
#
# Author: Hietan
# Email: hietan@example.com
# GitHub Repository: https://github.com/Hietan/Hietan_ZshTheme
# License: Apache Licence 2.0
# 
# © 2024 Hietan
#

# Generic function to retrieve the project name
# $1: Project definition file name (e.g., package.json, Cargo.toml)
# $2: Regular expression to extract the project name
function hietan_project_name {
	local filename=$1
	local regex=$2
	local dir=$(pwd)

	while [ "$dir" != "/" ]; do
		if [ -f "$dir/$filename" ]; then
      echo "$(grep -o "$regex" "$dir/$filename" | sed -E 's/.*"([^"]+)".*/\1/')"
			return
		fi
		dir=$(dirname "$dir")
	done
}

# Combines an icon with a name if the name is not empty.
# $1: Icon
# $2: Name
function hietan_update_name {
  local icon=$1
  local name=$2

  if [[ -n $name ]]; then
    echo "$icon $name"
  else
    echo ""
  fi
}

# Constructs a prompt string by concatenating items passed as arguments.
# Each item is separated by the HIETAN_SPLITTER symbol except the first item.
# $@: Items to be concatenated
function hietan_echo_prompt {
	local items=("$@")
	local item
	local prompt=""
	local first=true

	for item in "${items[@]}"; do
		if [[ -z ${(P)item} ]]; then
			continue
		fi
		if $first; then
			prompt+="${(P)item}"
			first=false
		else
			prompt+=" ${HIETAN_SPLITTER} "
			prompt+="${(P)item}"
		fi
	done

	echo $prompt
}

# Characters
HIETAN_SPLITTER=$'\Uf01d9'
HIETAN_START=$'\uf460'
HIETAN_STATUS_SUCCESS_ICON=$'\Uf0e1e'
HIETAN_STATUS_ERROR_ICON=$'\Uf1398'

# Color scheme
# Codex takes priority if both environment variables are present.
if [[ ${CODEX_SHELL:-} == 1 ]]; then
  HIETAN_COLOR_SCHEME=light
elif [[ ${TERM_PROGRAM:-} == iTerm.app ]]; then
  HIETAN_COLOR_SCHEME=dark
else
  # Set this to "dark" or "light" before loading the theme to override the default.
  HIETAN_COLOR_SCHEME=${HIETAN_COLOR_SCHEME:-dark}
fi

# Dark color palette
HIETAN_COLOR_DARK_TEXT='#000000'
HIETAN_COLOR_DARK_BACKGROUND='#808080'
HIETAN_COLOR_DARK_BAR='#000000'
HIETAN_COLOR_DARK_PROMPT='#ffffff'
HIETAN_COLOR_DARK_STATUS_SUCCESS='#008700'
HIETAN_COLOR_DARK_STATUS_ERROR='#c33126'

# Light color palette
HIETAN_COLOR_LIGHT_TEXT='#ffffff'
HIETAN_COLOR_LIGHT_BACKGROUND='#585858'
HIETAN_COLOR_LIGHT_BAR='#e0e0e0'
HIETAN_COLOR_LIGHT_PROMPT='#000000'
HIETAN_COLOR_LIGHT_STATUS_SUCCESS='#008700'
HIETAN_COLOR_LIGHT_STATUS_ERROR='#d70000'

function hietan_set_color_scheme {
  case "$HIETAN_COLOR_SCHEME" in
    light)
      HIETAN_COLOR_TEXT=$HIETAN_COLOR_LIGHT_TEXT
      HIETAN_COLOR_BACKGROUND=$HIETAN_COLOR_LIGHT_BACKGROUND
      HIETAN_COLOR_BAR=$HIETAN_COLOR_LIGHT_BAR
      HIETAN_COLOR_PROMPT=$HIETAN_COLOR_LIGHT_PROMPT
      HIETAN_COLOR_STATUS_SUCCESS=$HIETAN_COLOR_LIGHT_STATUS_SUCCESS
      HIETAN_COLOR_STATUS_ERROR=$HIETAN_COLOR_LIGHT_STATUS_ERROR
      ;;
    dark)
      HIETAN_COLOR_TEXT=$HIETAN_COLOR_DARK_TEXT
      HIETAN_COLOR_BACKGROUND=$HIETAN_COLOR_DARK_BACKGROUND
      HIETAN_COLOR_BAR=$HIETAN_COLOR_DARK_BAR
      HIETAN_COLOR_PROMPT=$HIETAN_COLOR_DARK_PROMPT
      HIETAN_COLOR_STATUS_SUCCESS=$HIETAN_COLOR_DARK_STATUS_SUCCESS
      HIETAN_COLOR_STATUS_ERROR=$HIETAN_COLOR_DARK_STATUS_ERROR
      ;;
    *)
      echo "hietan: unknown color scheme '$HIETAN_COLOR_SCHEME'; using dark" >&2
      HIETAN_COLOR_SCHEME=dark
      hietan_set_color_scheme
      ;;
  esac

  HIETAN_STATUS="%(?.%F{${HIETAN_COLOR_TEXT}}%K{${HIETAN_COLOR_STATUS_SUCCESS}} ${HIETAN_STATUS_SUCCESS_ICON} .%F{${HIETAN_COLOR_TEXT}}%K{${HIETAN_COLOR_STATUS_ERROR}} ${HIETAN_STATUS_ERROR_ICON} )%f"
}

hietan_set_color_scheme

# Time
HIETAN_TIME_ICON=$'\Uf0954'
HIETAN_TIME="${HIETAN_TIME_ICON} %D{%Y-%m-%d %H:%M:%S}"

# Directory
HIETAN_DIRECTORY_ICON=$'\Uf024b'
HIETAN_DIRECTORY="${HIETAN_DIRECTORY_ICON} %~"

# Git (Option)
HIETAN_GIT_ICON=$'\Uf02a2'
ZSH_THEME_GIT_PROMPT_PREFIX="${HIETAN_SPLITTER} ${HIETAN_GIT_ICON} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" \Uf0590"
ZSH_THEME_GIT_PROMPT_CLEAN=" \ue30d"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" \uf420"
ZSH_THEME_GIT_PROMPT_ADDED=" \uf067"
ZSH_THEME_GIT_PROMPT_MODIFIED=" \uea73"
ZSH_THEME_GIT_PROMPT_RENAMED=" \uf021"
ZSH_THEME_GIT_PROMPT_DELETED=" \Uf01b4"
ZSH_THEME_GIT_PROMPT_UNMERGED=" \uf419"
ZSH_THEME_GIT_PROMPT_AHEAD=" \uf432"
ZSH_THEME_GIT_PROMPT_BEHIND=" \uf434"
ZSH_THEME_GIT_PROMPT_DIVERGED=" \ue728"
ZSH_THEME_GIT_PROMPT_STASHED=" \Uf0613"
HIETAN_GIT='$(git_prompt_info)$(git_prompt_status)'

# Anaconda (Option)
function hietan_anaconda_env_name {
	if [[ -n ${CONDA_DEFAULT_ENV:-} ]]; then
		echo "$CONDA_DEFAULT_ENV"
	fi
}
HIETAN_ANACONDA_ICON=$'\Uf0320'

# Rye (Option)
HIETAN_RYE_ICON=$'\Uf0320'

# npm (Option)
HIETAN_NPM_ICON=$'\Uf031e'

# Cargo (Option)
HIETAN_CARGO_ICON=$'\Uf1617'

# Precommand
HIETAN_ITEMS=(HIETAN_TIME HIETAN_DIRECTORY HIETAN_ANACONDA HIETAN_RYE HIETAN_NPM HIETAN_CARGO)
function hietan_precmd {
	HIETAN_ANACONDA_NAME=$(hietan_anaconda_env_name)
	HIETAN_ANACONDA=$(hietan_update_name "$HIETAN_ANACONDA_ICON" "$HIETAN_ANACONDA_NAME")

	HIETAN_NPM_NAME=$(hietan_project_name "package.json" '"name": "[^"]*"')
	HIETAN_NPM=$(hietan_update_name "$HIETAN_NPM_ICON" "$HIETAN_NPM_NAME")

	HIETAN_CARGO_NAME=$(hietan_project_name "Cargo.toml" 'name\s*=\s*"[^"]*"')
	HIETAN_CARGO=$(hietan_update_name "$HIETAN_CARGO_ICON" "$HIETAN_CARGO_NAME")

	HIETAN_RYE_NAME=$(hietan_project_name "pyproject.toml" '^\s*name\s*=\s*"[^"]*"')
	HIETAN_RYE=$(hietan_update_name "$HIETAN_RYE_ICON" "$HIETAN_RYE_NAME")

# Prompt
PROMPT="
%K{${HIETAN_COLOR_BAR}}%B${HIETAN_STATUS}%F{${HIETAN_COLOR_TEXT}}%K{${HIETAN_COLOR_BACKGROUND}} $(hietan_echo_prompt "${HIETAN_ITEMS[@]}") ${HIETAN_GIT} %f%b%K{${HIETAN_COLOR_BAR}}%E
%F{${HIETAN_COLOR_PROMPT}}${HIETAN_START}%f%k "
RPROMPT='%F{${HIETAN_COLOR_BACKGROUND}}%n@%m%f'
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd hietan_precmd
