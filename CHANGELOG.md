# Changelog

All notable changes to Hietan Zsh Theme are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [2.1.0] - 2026-11-08

### Added

- Explicit macOS Terminal detection via `TERM_PROGRAM=Apple_Terminal`,
  defaulting to dark while respecting `HIETAN_COLOR_SCHEME`.

### Changed

- Use uv (`HIETAN_UV*`) for the Python project segment while retaining
  `HIETAN_RYE*` compatibility aliases for 2.x customizations.

### Fixed

- Initialize the Git prompt before Oh My Zsh registers asynchronous handlers.
- Render project and environment names as data, preventing shell command
  substitution and prompt-format injection.
- Create the custom themes directory in the Git installation instructions.
- Include linked documentation and behavior tests in release bundles.
- Run behavior checks on both Linux and macOS.

## [2.0.0] - 2026-08-05

### Added

- Dark and light color palettes controlled by `HIETAN_COLOR_SCHEME`.
- Automatic light mode in Codex shells and dark mode in iTerm2.
- Theme-specific colors for prompt text, bars, input markers, and command status.
- Automated Zsh syntax and behavior tests.
- GitHub community files, issue forms, CI, and tag-based releases.

### Changed

- Status indicators now use bold, cell-safe Nerd Font glyphs with colored
  backgrounds.
- Internal functions and variables now use `hietan_` and `HIETAN_` namespaces.
- Prompt updates are registered with `add-zsh-hook` instead of defining the
  global `precmd` function.
- Project metadata matching accepts flexible whitespace without requiring
  Perl-compatible `grep` expressions.
- The second-line prompt colors only the input marker, leaving its following
  space in the terminal's default colors.

### Fixed

- Prevented command status icons from being clipped in fixed-cell terminals.
- Prevented the Anaconda icon from being displayed twice.
- Prevented duplicate prompt hooks after reloading the theme.

### Breaking

- Previously unprefixed internal variables and helper functions are no longer
  exposed. Customizations must use the corresponding `HIETAN_*` variables.

## [1.1.1] - 2024-08-11

- Improved project-name detection portability.

## [1.1.0] - 2024-08-11

- Added project information and prompt refinements.

## [1.0.0] - 2024-07-23

- First stable theme release.

[Unreleased]: https://github.com/Hietan/Hietan_ZshTheme/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/Hietan/Hietan_ZshTheme/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/Hietan/Hietan_ZshTheme/compare/v1.1.1...v2.0.0
[1.1.1]: https://github.com/Hietan/Hietan_ZshTheme/releases/tag/v1.1.1
[1.1.0]: https://github.com/Hietan/Hietan_ZshTheme/releases/tag/v1.1
[1.0.0]: https://github.com/Hietan/Hietan_ZshTheme/releases/tag/v1.0
