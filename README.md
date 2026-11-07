# Hietan Zsh Theme

[![CI](https://github.com/Hietan/Hietan_ZshTheme/actions/workflows/ci.yml/badge.svg)](https://github.com/Hietan/Hietan_ZshTheme/actions/workflows/ci.yml)
[![GitHub Release](https://img.shields.io/github/v/release/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/releases/latest)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

Hietan is a two-line Oh My Zsh theme that shows command status, time, the
current directory, Git state, environments, and project metadata. Version 2
provides configurable dark and light palettes for terminals with different
backgrounds.

![Hietan Zsh Theme](https://github.com/user-attachments/assets/126739ff-f537-4305-a7d6-e9f81d8b66ce)

## Features

- Success and failure indicators with high-contrast backgrounds.
- Date, time, and current directory.
- Git branch and working-tree status through Oh My Zsh.
- Anaconda environment name.
- Project names from parent `package.json`, `Cargo.toml`, and `pyproject.toml`
  files.
- Configurable colors per terminal application, defaulting to dark.
- Namespaced helpers and a reusable `precmd` hook.

## Requirements

- Zsh
- [Oh My Zsh](https://ohmyz.sh/)
- A [Nerd Font](https://www.nerdfonts.com/)

Git, Anaconda, Node.js package metadata, Cargo, and Python project metadata are
optional. Missing tools or metadata simply leave their prompt segment empty.
Python project names include uv projects with a double-quoted `name`
in `pyproject.toml`, including from nested directories. Activating a virtual
environment alone does not add a project name.

Project metadata detection uses simple text matching, not full JSON or TOML
parsing. Use double-quoted names; files containing multiple matching `name`
entries may display multiple names. Git status is provided by Oh My Zsh,
including its asynchronous prompt support.

## Installation

Download the latest released theme into the Oh My Zsh custom themes directory:

```sh
theme_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
mkdir -p "$theme_dir"
curl -fsSL \
  https://github.com/Hietan/Hietan_ZshTheme/releases/latest/download/hietan.zsh-theme \
  -o "$theme_dir/hietan.zsh-theme"
```

Set the theme in `~/.zshrc`:

```sh
ZSH_THEME="hietan"
```

Reload Zsh:

```sh
exec zsh
```

### Install from Git

For development or tracking `main`, clone the repository and link the theme:

```sh
git clone https://github.com/Hietan/Hietan_ZshTheme.git
mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
ln -s "$PWD/Hietan_ZshTheme/hietan.zsh-theme" \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/hietan.zsh-theme"
```

## Color schemes

The theme identifies the application through `TERM_PROGRAM`. When
`CODEX_SHELL=1`, it identifies the session as Codex instead. It does not query
the actual background color or the macOS appearance.

All terminals default to **dark**, including Ghostty, iTerm2, macOS Terminal,
and Codex.
No configuration file or environment variable is required.

To choose colors without editing the theme, set variables in `~/.zshrc`
**before** loading Oh My Zsh:

```sh
# Optional common fallback (defaults to dark).
HIETAN_COLOR_SCHEME=dark

# Optional per-application overrides.
HIETAN_COLOR_SCHEME_CODEX=light
HIETAN_COLOR_SCHEME_GHOSTTY=dark
HIETAN_COLOR_SCHEME_ITERM_APP=dark
HIETAN_COLOR_SCHEME_APPLE_TERMINAL=light
HIETAN_COLOR_SCHEME_VSCODE=dark

ZSH_THEME="hietan"
source "$ZSH/oh-my-zsh.sh"
```

| Application | Identification | Override variable |
| --- | --- | --- |
| Codex | `CODEX_SHELL=1` | `HIETAN_COLOR_SCHEME_CODEX` |
| Ghostty | `TERM_PROGRAM=ghostty` | `HIETAN_COLOR_SCHEME_GHOSTTY` |
| iTerm2 | `TERM_PROGRAM=iTerm.app` | `HIETAN_COLOR_SCHEME_ITERM_APP` |
| macOS Terminal | `TERM_PROGRAM=Apple_Terminal` | `HIETAN_COLOR_SCHEME_APPLE_TERMINAL` |
| VS Code terminal | `TERM_PROGRAM=vscode` | `HIETAN_COLOR_SCHEME_VSCODE` |

These are configuration examples, not an exclusive list of supported apps.
To check the identity exposed by your terminal, run `print -r -- "$TERM_PROGRAM"`.

For another terminal, uppercase its `TERM_PROGRAM` value, replace each
character outside `A-Z` and `0-9` with `_`, and prepend
`HIETAN_COLOR_SCHEME_`. If `TERM_PROGRAM` is missing, the key is `UNKNOWN`.

Precedence is: nonempty application override, nonempty `HIETAN_COLOR_SCHEME`,
then `dark`. Codex sessions use the Codex override even when `TERM_PROGRAM`
identifies the host terminal. Empty settings are treated as unspecified.
Valid values are `dark` and `light`; an invalid selected value prints a warning
and falls back to dark. Start a new shell with `exec zsh` after changing settings.

In 2.0, Codex and iTerm2 forced light and dark respectively. To retain the old
Codex behavior, set `HIETAN_COLOR_SCHEME_CODEX=light`.

## Updating

Repeat the release download command from the installation section. The latest
release asset replaces the installed theme file.

## Migrating from 1.x

Version 2 namespaces internal helpers and variables. Custom configurations that
referenced names such as `COLOR_TEXT`, `STATUS`, `TIME`, or `project_name` must
use their `HIETAN_*` or `hietan_*` equivalents. Standard Oh My Zsh installation
and `ZSH_THEME="hietan"` configuration are unchanged.

## Migrating from 2.0

The Python project segment now uses `HIETAN_UV`, `HIETAN_UV_NAME`, and
`HIETAN_UV_ICON` as the preferred names. The previous `HIETAN_RYE*` variables
remain available as compatibility aliases in 2.x. Detection uses
`pyproject.toml` and does not require the uv command or a `uv.lock` file.

## Development

Run the complete local checks:

```sh
zsh -n hietan.zsh-theme
zsh tests/test_theme.zsh
```

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for contribution guidelines and
[`RELEASE.md`](RELEASE.md) for the release checklist.

## Support and security

- Read [`SUPPORT.md`](SUPPORT.md) before opening a support issue.
- Report vulnerabilities according to [`SECURITY.md`](SECURITY.md).
- Review changes in [`CHANGELOG.md`](CHANGELOG.md).

## License

Licensed under the Apache License 2.0. See [`LICENSE`](LICENSE) and
[`NOTICE`](NOTICE).
