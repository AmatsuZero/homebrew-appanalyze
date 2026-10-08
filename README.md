# homebrew-appanalyze

[Homebrew](https://brew.sh) tap for [APPAnalyze](https://github.com/helele90/APPAnalyze) — a command-line tool that analyzes iOS componentized projects to automatically detect app package-size issues and generate size metrics/reports.

APPAnalyze is distributed upstream only as source (the latest release ships no prebuilt binary). This tap provides a **prebuilt arm64 (Apple Silicon) binary** built from upstream tag `1.5.0`, hosted as a release asset in this repository. Source is Apache-2.0 licensed.

## Install

```sh
brew tap AmatsuZero/appanalyze
brew install appanalyze
```

Then run it:

```sh
appanalyze --help
appanalyze --project <proj> --output <out> --ipa <ipa>
```

## Notes

- **Apple Silicon only.** The formula refuses to install on Intel Macs (`on_intel` guard).
- The upstream binary reports its internal version as `1.3.1` in `--help` even when built from the `1.5.0` tag (a hardcoded string upstream); the formula `version` reflects the upstream source tag.
- To bump to a newer upstream tag: rebuild the binary (see build notes), upload a new release asset `appanalyze-<version>.zip`, and update `url` + `sha256` in `Formula/appanalyze.rb`.

## Build the binary yourself

```sh
git clone --depth 1 --branch 1.5.0 https://github.com/helele90/APPAnalyze.git
cd APPAnalyze/APPAnalyze
xcodebuild -scheme APPAnalyzeCommand -configuration Release -arch arm64 \
  MACOSX_DEPLOYMENT_TARGET=12.0 -derivedDataPath build
BIN=$(find build/Build/Products/Release -name APPAnalyzeCommand)
cp "$BIN" appanalyze
codesign --force --deep --sign - appanalyze
zip appanalyze-1.5.0.zip appanalyze
shasum -a 256 appanalyze-1.5.0.zip
```
