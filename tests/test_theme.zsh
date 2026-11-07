#!/usr/bin/env zsh

setopt ERR_EXIT NO_UNSET PIPE_FAIL

readonly repo_root=${0:A:h:h}
readonly theme_file="$repo_root/hietan.zsh-theme"

function fail {
  print -u2 -r -- "FAIL: $1"
  exit 1
}

function assert_equal {
  local actual=$1
  local expected=$2
  local message=$3

  [[ $actual == $expected ]] || fail "$message (expected '$expected', got '$actual')"
}

function assert_contains {
  local actual=$1
  local expected=$2
  local message=$3

  [[ $actual == *$expected* ]] || fail "$message (missing '$expected')"
}

theme_version=$(sed -n 's/^# Version: //p' "$theme_file")
[[ $theme_version =~ '^[0-9]+\.[0-9]+\.[0-9]+$' ]] || \
  fail "theme version is not valid semantic versioning"

unset CODEX_SHELL TERM_PROGRAM HIETAN_COLOR_SCHEME CONDA_DEFAULT_ENV
source "$theme_file"

# Oh My Zsh checks these substitutions before running the theme's precmd.
assert_contains "$PROMPT" '$(git_prompt_info)' "initial Git info registration"
assert_contains "$PROMPT" '$(git_prompt_status)' "initial Git status registration"

assert_equal "$HIETAN_COLOR_SCHEME" dark "default scheme"
assert_equal "$HIETAN_COLOR_TEXT" '#000000' "dark text color"
assert_equal "$HIETAN_COLOR_STATUS_SUCCESS" '#008700' "dark success color"
assert_equal "$HIETAN_COLOR_STATUS_ERROR" '#c33126' "dark error color"

HIETAN_COLOR_SCHEME=light
hietan_set_color_scheme
assert_equal "$HIETAN_COLOR_TEXT" '#ffffff' "light text color"
assert_equal "$HIETAN_COLOR_STATUS_SUCCESS" '#008700' "light success color"
assert_equal "$HIETAN_COLOR_STATUS_ERROR" '#d70000' "light error color"
assert_contains "$HIETAN_STATUS" '%K{#008700}' "success background"
assert_contains "$HIETAN_STATUS" '%K{#d70000}' "error background"

HIETAN_COLOR_SCHEME=invalid
hietan_set_color_scheme 2>/dev/null
assert_equal "$HIETAN_COLOR_SCHEME" dark "invalid scheme fallback"

env CODEX_SHELL=1 TERM_PROGRAM=iTerm.app zsh -fc \
  'source "$1"; [[ $HIETAN_COLOR_SCHEME == light ]]' _ "$theme_file" || \
  fail "Codex should take priority and select light mode"

env -u CODEX_SHELL TERM_PROGRAM=iTerm.app zsh -fc \
  'source "$1"; [[ $HIETAN_COLOR_SCHEME == dark ]]' _ "$theme_file" || \
  fail "iTerm should select dark mode"

env -u CODEX_SHELL -u HIETAN_COLOR_SCHEME TERM_PROGRAM=Apple_Terminal zsh -fc \
  'source "$1"; [[ $HIETAN_COLOR_SCHEME == dark ]]' _ "$theme_file" || \
  fail "Apple Terminal should default to dark mode"

env -u CODEX_SHELL HIETAN_COLOR_SCHEME=light TERM_PROGRAM=Apple_Terminal zsh -fc \
  'source "$1"; [[ $HIETAN_COLOR_SCHEME == light ]]' _ "$theme_file" || \
  fail "Apple Terminal should accept a light profile override"

env CODEX_SHELL=1 TERM_PROGRAM=Apple_Terminal zsh -fc \
  'source "$1"; [[ $HIETAN_COLOR_SCHEME == light ]]' _ "$theme_file" || \
  fail "Codex should take priority over Apple Terminal"

CONDA_DEFAULT_ENV=test-env
hietan_precmd
assert_equal "$HIETAN_ANACONDA" "$HIETAN_ANACONDA_ICON test-env" \
  "Anaconda segment"

unset CONDA_DEFAULT_ENV
hietan_precmd
assert_equal "$HIETAN_ANACONDA" '' "empty Anaconda segment"

readonly test_dir=$(mktemp -d "${TMPDIR:-/tmp}/hietan-theme-test.XXXXXX")
trap 'rm -rf -- "$test_dir"' EXIT

mkdir -p "$test_dir/project/nested"
print -r -- '{"name":"node-demo"}' > "$test_dir/project/package.json"
print -r -- 'name = "cargo-demo"' > "$test_dir/project/Cargo.toml"
print -r -- '  name = "python-demo"' > "$test_dir/project/pyproject.toml"
print -r -- 'version = 1' > "$test_dir/project/uv.lock"

cd "$test_dir/project/nested"
hietan_precmd
assert_equal "$HIETAN_NPM_NAME" node-demo "npm project name"
assert_equal "$HIETAN_CARGO_NAME" cargo-demo "Cargo project name"
assert_equal "$HIETAN_UV_NAME" python-demo "Python project name"
assert_equal "$HIETAN_NPM" "$HIETAN_NPM_ICON node-demo" "npm segment"
assert_equal "$HIETAN_CARGO" "$HIETAN_CARGO_ICON cargo-demo" "Cargo segment"
assert_equal "$HIETAN_UV" "$HIETAN_UV_ICON python-demo" "Python segment"
assert_equal "$HIETAN_RYE_NAME" "$HIETAN_UV_NAME" "legacy Python name alias"
assert_equal "$HIETAN_RYE" "$HIETAN_UV" "legacy Python segment alias"
assert_contains "$PROMPT" "${HIETAN_START}%f%k " "uncolored input space"

rm "$test_dir/project/uv.lock"
hietan_precmd
assert_equal "$HIETAN_UV_NAME" python-demo "Python detection without uv.lock"

# Repository metadata and environment names must never execute at render time.
print -r -- 'name = "$(touch command-marker)`touch backtick-marker`%F{red}uv"' \
  > "$test_dir/project/pyproject.toml"
CONDA_DEFAULT_ENV='$(touch conda-marker)%F{blue}env'
function git_prompt_info { :; }
function git_prompt_status { :; }
setopt PROMPT_SUBST
hietan_precmd
rendered_prompt=$(print -P -- "$PROMPT")
assert_contains "$rendered_prompt" '$(touch command-marker)`touch backtick-marker`%F{red}uv' \
  "project name rendered literally"
assert_contains "$rendered_prompt" '$(touch conda-marker)%F{blue}env' \
  "environment name rendered literally"
[[ ! -e command-marker && ! -e backtick-marker && ! -e conda-marker ]] || \
  fail "metadata executed a command"
unset CONDA_DEFAULT_ENV

mkdir -p "$test_dir/empty"
cd "$test_dir/empty"
hietan_precmd
assert_equal "$HIETAN_UV" '' "Python segment cleared outside project"
assert_equal "$HIETAN_RYE" '' "legacy Python segment cleared outside project"
assert_equal "$HIETAN_NPM" '' "npm segment cleared outside project"
assert_equal "$HIETAN_CARGO" '' "Cargo segment cleared outside project"

unset item
hietan_echo_prompt HIETAN_TIME HIETAN_DIRECTORY >/dev/null
(( ! ${+item} )) || fail "prompt item loop leaked a global variable"

(( ! ${+functions[project_name]} )) || fail "legacy project_name function leaked"
(( ! ${+functions[update_name]} )) || fail "legacy update_name function leaked"
(( ! ${+functions[echo_prompt]} )) || fail "legacy echo_prompt function leaked"
(( ! ${+functions[anaconda_env_name]} )) || fail "legacy Anaconda function leaked"
(( ! ${+functions[precmd]} )) || fail "global precmd function was replaced"

source "$theme_file"
readonly hook_count=${(M)#precmd_functions:#hietan_precmd}
assert_equal "$hook_count" 1 "precmd hook count after reload"

cd "$repo_root"
print -r -- "All theme tests passed."
