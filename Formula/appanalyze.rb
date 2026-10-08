class Appanalyze < Formula
  desc "Analyze iOS componentized projects to detect app package size issues"
  homepage "https://github.com/helele90/APPAnalyze"
  url "https://github.com/AmatsuZero/homebrew-appanalyze/releases/download/v1.5.0/appanalyze-1.5.0.zip"
  sha256 "56840556133dae42b6a3614ca51c4b2d4175feadeb1195b1eee80a15421b7a06"
  version "1.5.0"
  license "Apache-2.0"

  # Prebuilt arm64 (Apple Silicon) binary only.
  on_intel do
    odie "appanalyze is only supported on Apple Silicon (arm64) macOS."
  end

  def install
    bin.install "appanalyze"
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/appanalyze --help")
  end
end
