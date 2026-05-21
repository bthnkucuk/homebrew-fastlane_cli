# typed: false
# frozen_string_literal: true

# Homebrew formula for fastlane_cli.
#
# v0.1.0 ships macos-arm64 only (built locally — the GitHub Actions
# macos-13 / linux runners were either unavailable or unbuilt at
# release time). macos-x86_64 and linux-x86_64 will be re-added in
# v0.1.1 once those legs come back online. Until then, Intel Mac and
# Linux users should build from source per the README's "From source"
# instructions.
class FastlaneCli < Formula
  desc "Terminal-first Fastlane assistant for Flutter projects"
  homepage "https://github.com/bthnkucuk/fastlane_cli"
  version "0.4.3"
  license "MIT"

  depends_on "fastlane"

  # v0.1.0: only macos-arm64 ships. on_intel + on_linux blocks are
  # intentionally absent so brew bails with a clear "no available
  # bottle" error on those platforms instead of trying a missing URL.
  on_macos do
    on_arm do
      url "https://github.com/bthnkucuk/fastlane_cli/releases/download/v0.4.3/fastlane_cli-macos-arm64.tar.gz"
      sha256 "2cad98e945ba8b94ec7a34c78c0b50e3bd6c710a852539cf0391e072a88deb8c"
    end
  end

  def install
    # `.github/workflows/release.yml` tars `build/fastlane_cli` plus the
    # `fastlane/` and `skills/` payload directories (and README / LICENSE
    # when present). Layout inside the tarball:
    #   build/fastlane_cli   — compiled Dart binary
    #   fastlane/            — Ruby/Fastlane runner assets
    #   skills/              — bundled Claude Code / Cursor skills
    bin.install "build/fastlane_cli"
    (share/"fastlane_cli").install "fastlane"
    (share/"fastlane_cli").install "skills"
  end

  def caveats
    <<~EOS
      One-time setup — drop the bundled Claude Code / Cursor skills into
      your Flutter project's `.claude/` and `.cursor/` directories:

        fastlane_cli skills install --project

      Or install them once for every project under your user account:

        fastlane_cli skills install --global

      The bundled Fastlane runner lives at:
        #{opt_share}/fastlane_cli/fastlane

      On first lane run, fastlane_cli will materialise a per-user bundle
      cache under ~/Library/Caches/fastlane_cli (macOS) or
      ~/.cache/fastlane_cli (Linux). Run `fastlane_cli doctor` if anything
      goes wrong.
    EOS
  end

  test do
    help_output = shell_output("#{bin}/fastlane_cli --help")
    # Smoke: the binary runs and prints its own name in the help banner.
    assert_match "fastlane_cli", help_output
    # Confirms the CommandRunner subcommand layer (Track A2) is wired —
    # `completion` is the cheapest subcommand to name-check here because it
    # does not require a profile, network, or filesystem mutation.
    assert_match "completion", help_output
  end
end
