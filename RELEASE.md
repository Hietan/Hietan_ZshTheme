# Release Process

Hietan Zsh Theme is released through GitHub tags and GitHub Releases.

## Versioning

Releases follow Semantic Versioning. The release version appears in the header
of `hietan.zsh-theme`, and tags use the form `vX.Y.Z`.

- Patch releases contain compatible fixes.
- Minor releases add compatible functionality.
- Major releases may change configuration names or prompt behavior.

The `HIETAN_UV*` names introduced in 2.1 retain `HIETAN_RYE*` compatibility
aliases throughout 2.x. Remove those aliases only in a major release.

## Checklist

1. Start from an up-to-date `main` branch with a clean worktree.
2. Update the version in `hietan.zsh-theme`.
3. Move entries from `Unreleased` into a dated section in `CHANGELOG.md`.
4. Update screenshots and user documentation when prompt visuals changed.
5. Run:

   ```sh
   zsh -n hietan.zsh-theme
   zsh tests/test_theme.zsh
   ```

   In a fresh interactive Oh My Zsh session, confirm that Git information
   appears on the first prompt after asynchronous loading and updates when
   moving between a repository, its nested directories, and a non-repository
   directory. Check both successful and failed command indicators.

   Check the default dark scheme with no color settings, an application-specific
   override, and the common fallback. Verify project segments both with and
   without metadata, including a Python project without `uv.lock`.

6. Confirm that the release tag does not already exist.
7. Commit the release preparation.
8. Push `main` and wait for both Linux and macOS CI checks to pass on that exact
   commit. A successful check from an older commit is not sufficient.
9. Create and push the annotated tag:

   ```sh
   git tag -a vX.Y.Z -m "Release X.Y.Z"
   git push origin vX.Y.Z
   ```

10. Confirm that the `Release` workflow publishes the GitHub Release and
    attaches `hietan.zsh-theme`, `.tar.gz` and `.zip` bundles, and
    `SHA256SUMS`. The archives must include `README.md`, `CHANGELOG.md`,
    `LICENSE`, `NOTICE`, linked support and contribution documents, and `tests/`.
    Release notes are extracted from the matching `CHANGELOG.md` section.
11. Download the release asset and run a final syntax check.

## Failed releases

Do not move or reuse a published tag. Fix the problem in a new patch release and
document it in `CHANGELOG.md`.
