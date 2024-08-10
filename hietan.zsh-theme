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
GIT_HEAD=" ${SPLITTER} ${GIT_ICON} "
ZSH_THEME_GIT_PROMPT_PREFIX=" ${GIT_HEAD}"
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
ANACONDA_ICON=$'\Uf0320'
function anaconda_env_name {
	if [[ -n $CONDA_DEFAULT_ENV ]]; then
		echo " ${SPLITTER} ${ANACONDA_ICON} $CONDA_DEFAULT_ENV"
	fi
}
ANACONDA='$ANACONDA_ICON $(anaconda_env_name)'

# npm (Option)
JS_ICON=$'\Uf031e'
function npm_project_name {
  local dir=$(pwd)
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/package.json" ]; then
      echo "($(node -p "require('$dir/package.json').name"))"
      return
    fi
    dir=$(dirname "$dir")
  done
}
JS='$JS_ICON $(npm_project_name)'

# cargo (Option)
RUST_ICON=$'\Uf1617'
function cargo_project_name {
	local dir=$(pwd)
	while [ "$dir" != "/" ]; do
		if [ -f "$dir/Cargo.toml" ]; then
			echo "($(cat $dir/Cargo.toml | grep -oP '(?<=name = ").*(?=")'))"
			return
		fi
		dir=$(dirname "$dir")
	done
}
RUST='$RUST_ICON $(cargo_project_name)'


PROMPT="
%K{${COLOR_BAR}} ${STATUS} %F{${COLOR_TEXT}}%K{${COLOR_BACKGROUND}}%B ${TIME} ${SPLITTER} ${DIRECTORY}${GIT}${ANACONDA}${JS}${RUST} %f%b%K{${COLOR_BAR}}%E
 ${START} %f%k"
RPROMPT='%F{${COLOR_BACKGROUND}}%n@%m%f'
