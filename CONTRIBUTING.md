# Contributing

Thank you for considering a contribution to Hietan Zsh Theme.

## Development setup

Requirements:

- Zsh
- Git
- Oh My Zsh for manual prompt testing
- A Nerd Font for visual testing

Clone the repository and run the checks:

```sh
git clone https://github.com/Hietan/Hietan_ZshTheme.git
cd Hietan_ZshTheme
zsh -n hietan.zsh-theme
zsh tests/test_theme.zsh
```

## Making changes

1. Create a focused branch from `main`.
2. Keep theme behavior in `hietan.zsh-theme`.
3. Add or update tests for behavior changes.
4. Update `README.md` and `CHANGELOG.md` for user-visible changes.
5. Run all checks before opening a pull request.

Use portable Zsh, two-space indentation for new blocks, `hietan_` for internal
functions, and `HIETAN_` for internal or configurable global variables.

Commit messages should be short, imperative, and title case, such as
`Fix Status Colors` or `Add Theme Tests`.

## Pull requests

Pull requests should explain:

- What prompt behavior changed.
- Why the change is needed.
- Which checks were run.
- Whether documentation was updated.

Include screenshots for changes to colors, icons, spacing, or layout. Test both
the presence and absence of optional tools or project metadata.

## Releases

Only maintainers publish releases. See [`RELEASE.md`](RELEASE.md) for the full
release checklist.
