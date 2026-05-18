# homebrew-fastlane_cli

Homebrew tap for [fastlane_cli](https://github.com/bthnkucuk/fastlane_cli) —
a terminal-first Fastlane assistant for any Flutter project.

## Install

```sh
brew install bthnkucuk/fastlane_cli/fastlane_cli
```

## What you get

- A Dart-AOT compiled `fastlane_cli` binary on your PATH.
- The bundled Fastlane runner (`Fastfile`s, helpers, store metadata defaults)
  at `$(brew --prefix)/share/fastlane_cli/fastlane/`.
- The bundled Claude skills at `$(brew --prefix)/share/fastlane_cli/skills/`,
  ready to drop into a consumer repo via `fastlane_cli skills install
  --project` (or `--global`).

## Updating the formula

The formula in this tap is rewritten by the release pipeline in the
upstream repo on every tag push. Manual edits will be overwritten — make
PRs against [bthnkucuk/fastlane_cli](https://github.com/bthnkucuk/fastlane_cli)
instead.
