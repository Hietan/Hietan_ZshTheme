# Hietan's ZshTheme

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/releases)
[![GitHub Issues](https://img.shields.io/github/issues/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/issues)
[![GitHub Forks](https://img.shields.io/github/forks/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/network/members)
[![GitHub Stars](https://img.shields.io/github/stars/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/stargazers)
[![GitHub last commit](https://img.shields.io/github/last-commit/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/commits/main)
[![Contributors](https://img.shields.io/github/contributors/Hietan/Hietan_ZshTheme)](https://github.com/Hietan/Hietan_ZshTheme/graphs/contributors)
[![Downloads](https://img.shields.io/github/downloads/Hietan/Hietan_ZshTheme/total)](https://github.com/Hietan/Hietan_ZshTheme/releases)

Customized Zsh theme that supports Git, Anaconda, Rye, npm, and Cargo projects.\
The theme offers icons, time, directory information, status indicators, and project information in the prompt.

## Features

![Thems's Screenshot](https://github.com/user-attachments/assets/126739ff-f537-4305-a7d6-e9f81d8b66ce)

- Display blow informations with icon
  - Status indicators
  - Date and Time
  - Directory
  - Git status
  - Anaconda environment name
  - Rye project name
  - npm (yarn) project name
  - Cargo project name

## Require

This theme requires below applications:

* Zsh
* [Oh My Zsh](https://ohmyz.sh/)
* [Nerd Fonts](https://www.nerdfonts.com/)

This theme also supports the following applications:

* Git (Option)
* [Anaconda](https://www.anaconda.com/) (Option)
* [Rye](https://rye.astral.sh/) (Option)
* [npm](https://www.npmjs.com/) (Option)
* [yarn](https://yarnpkg.com/) (Option)
* [Cargo](https://doc.rust-lang.org/cargo/index.html) (Option)

## Installation

To install the Hietan Zsh Theme, follow these steps:

1. **Clone the repository**:

   ```sh
   git clone https://github.com/Hietan/Hietan_ZshTheme.git
   ```

2. **Create a symbolic link to the theme in the Oh My Zsh themes directory**:

   ```sh
   ln -s $(pwd)/Hietan_ZshTheme/hietan.zsh-theme ~/.oh-my-zsh/themes/hietan.zsh-theme
   ```

3. **Set the theme to `hietan` in your `.zshrc`**:

   Open your `.zshrc` file in a text editor and modify the `ZSH_THEME` line:

   ```sh
   ZSH_THEME="hietan"
   ```

4. **Reload your Zsh configuration**:

   ```sh
   source ~/.zshrc
   ```

After completing these steps, the Hietan Zsh Theme should be active in your terminal.
