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
function project_name {
	local filename=$1
	local regex=$2
	local dir=$(pwd)

	while [ "$dir" != "/" ]; do
		if [ -f "$dir/$filename" ]; then
			echo "$(grep -oP "$regex" "$dir/$filename")"
			return
		fi
		dir=$(dirname "$dir")
	done
}

# Combines an icon with a name if the name is not empty.
# $1: Icon
# $2: Name
function update_name {
  local icon=$1
  local name=$2

  if [[ -n $name ]]; then
    echo "$icon $name"
  else
    echo ""
  fi
}

# Constructs a prompt string by concatenating items passed as arguments.
# Each item is separated by the SPLITTER symbol except the first item.
# $@: Items to be concatenated
function echo_prompt {
	local items=("$@")
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
			prompt+=" ${SPLITTER} "
			prompt+="${(P)item}"
		fi
	done

	echo $prompt
}

# Characters
SPLITTER=$'\Uf01d9'
START=$'\uf460'

# Colors
COLOR_TEXT=black
COLOR_BACKGROUND=242
COLOR_BAR=black

# Status
STATUS=$'%(?.%F{green}\Uf05e0.%F{red}\Uf0159)%f'

# Time
TIME_ICON=$'\Uf0954'
TIME="${TIME_ICON} %D{%Y-%m-%d %H:%M:%S}"

# Directory
DIRECTORY_ICON=$'\Uf024b'
DIRECTORY="${DIRECTORY_ICON} %~"

# Git (Option)
GIT_ICON=$'\Uf02a2'
ZSH_THEME_GIT_PROMPT_PREFIX="${SPLITTER} ${GIT_ICON} "
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
GIT='$(git_prompt_info)$(git_prompt_status)'

# Anaconda (Option)
function anaconda_env_name {
	if [[ -n $CONDA_DEFAULT_ENV ]]; then
		echo "${ANACONDA_ICON} $CONDA_DEFAULT_ENV"
	fi
}
ANACONDA_ICON=$'\Uf0320'

# Rye (Option)
RYE_ICON=$'\Uf0320'

# npm (Option)
NPM_ICON=$'\Uf031e'

# Cargo (Option)
CARGO_ICON=$'\Uf1617'

# Precommand
ITEMS=(TIME DIRECTORY ANACONDA RYE NPM CARGO)
precmd() {
	ANACONDA_NAME=$(anaconda_env_name)
	ANACONDA=$(update_name "$ANACONDA_ICON" "$ANACONDA_NAME")

	NPM_NAME=$(project_name "package.json" '(?<=name": ").*(?=")')
	NPM=$(update_name "$NPM_ICON" "$NPM_NAME")

	CARGO_NAME=$(project_name "Cargo.toml" '(?<=name = ").*(?=")')
	CARGO=$(update_name "$CARGO_ICON" "$CARGO_NAME")

	RYE_NAME=$(project_name "pyproject.toml" '(?m)^\s*name\s*=\s*"\K[^"]+')
	RYE=$(update_name "$RYE_ICON" "$RYE_NAME")

# Prompt
PROMPT="
%K{${COLOR_BAR}} ${STATUS} %F{${COLOR_TEXT}}%K{${COLOR_BACKGROUND}}%B $(echo_prompt "${ITEMS[@]}") ${GIT} %f%b%K{${COLOR_BAR}}%E
${START} %f%k"
RPROMPT='%F{${COLOR_BACKGROUND}}%n@%m%f'
}
