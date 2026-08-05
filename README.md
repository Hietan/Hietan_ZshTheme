# Hietan Zsh Theme

[![CI](https://github.com/Hietan/Hietan_ZshTheme/actions/workflows/ci.yml/badge.svg)](https://github.com/Hietan/Hietan_ZshTheme/actions/workflows/ci.yml)
[![GitHub Release](https://img.shields.io/github/v/release/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/releases/latest)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

Hietan is a two-line Oh My Zsh theme that shows command status, time, the
current directory, Git state, environments, and project metadata. Version 2
adds automatic dark and light palettes for terminals with different
backgrounds.

![Hietan Zsh Theme](https://github.com/user-attachments/assets/126739ff-f537-4305-a7d6-e9f81d8b66ce)

## Features

- Success and failure indicators with high-contrast backgrounds.
- Date, time, and current directory.
- Git branch and working-tree status through Oh My Zsh.
- Anaconda environment name.
- Project names from parent `package.json`, `Cargo.toml`, and `pyproject.toml`
  files.
- Automatic light mode in Codex and dark mode in iTerm2.
- Namespaced helpers and a reusable `precmd` hook.

## Requirements

- Zsh
- [Oh My Zsh](https://ohmyz.sh/)
- A [Nerd Font](https://www.nerdfonts.com/)

Git, Anaconda, Node.js package metadata, Cargo, and Python project metadata are
optional. Missing tools or metadata simply leave their prompt segment empty.

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
ln -s "$PWD/Hietan_ZshTheme/hietan.zsh-theme" \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/hietan.zsh-theme"
```

## Color schemes

The theme selects a color scheme from the terminal environment:

| Condition | Scheme |
| --- | --- |
| `CODEX_SHELL=1` | Light |
| `TERM_PROGRAM=iTerm.app` | Dark |
| Otherwise | `HIETAN_COLOR_SCHEME`, defaulting to dark |

Codex takes priority if both detection variables are present. In another
terminal, select a scheme before Oh My Zsh is loaded:

```sh
HIETAN_COLOR_SCHEME="light"
ZSH_THEME="hietan"
```

Valid values are `dark` and `light`. An unknown value prints a warning and
falls back to dark.

## Updating

Repeat the release download command from the installation section. The latest
release asset replaces the installed theme file.

## Migrating from 1.x

Version 2 namespaces internal helpers and variables. Custom configurations that
referenced names such as `COLOR_TEXT`, `STATUS`, `TIME`, or `project_name` must
use their `HIETAN_*` or `hietan_*` equivalents. Standard Oh My Zsh installation
and `ZSH_THEME="hietan"` configuration are unchanged.

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
