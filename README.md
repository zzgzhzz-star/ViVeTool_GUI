# ViVeTool GUI — maintained fork

[简体中文](README.zh-CN.md) · [Development log](DEVELOPMENT_LOG.md) · [中文开发日志](DEVELOPMENT_LOG.zh-CN.md) · [Downloads](https://github.com/zzgzhzz-star/ViVeTool_GUI/releases)

An **unofficial maintenance fork** of [PeterStrick/ViVeTool-GUI](https://github.com/PeterStrick/ViVeTool-GUI), built against the updated [ViVe / ViVeTool core](https://github.com/thebookisclosed/ViVe). This is not an official release from either upstream author or Microsoft.

## Version and provenance

| Component | Version / source revision |
|---|---|
| This GUI build | `1.7.0.1`, x64 |
| GUI base | upstream `v1.7-Testing`, `944b78ca16ede25d39f926d8994861d7aa95abcf` |
| ViVe core | `2025.3.10.0`, upstream `master`, `3f8c6a3425983412da1e8b26cd757c3aa17b3f25` |
| Bundled ViVeTool CLI | `0.3.4` |
| Upstream snapshot checked | 2026-11-02 |

The original GUI repository is archived. The source revisions above, rather than a claim of a new upstream release, identify exactly what this fork uses. Both upstream branches and their history are retained in this GitHub fork.

## What changed

- Build the GUI against the current ViVe source project instead of the bundled 2023 core DLL.
- Include a separately compiled ViVeTool CLI and the upstream feature dictionary.
- Default to Simplified Chinese while retaining upstream language resources and the language selector.
- Fix `IndexOutOfRangeException` in `PopulateBuildComboBox()` by parsing build filenames independently of repository directory depth.
- Fix Release compilation, empty feature lists, dependency binding, and disposal of an uninitialized Sentry client.
- Correct variant updates so a variant number is not also written as an external payload.
- Disable the archived upstream automatic updater and the retired comments database connection at startup.
- Add a startup error log, a build script, and read-only regression checks.

## Download and run

Download the x64 runtime ZIP from [Releases](https://github.com/zzgzhzz-star/ViVeTool_GUI/releases), **extract the entire archive**, and run `ViVeTool_GUI.exe` as administrator. Keep the DLLs, configuration files, language folders, and runtime directories together. The `CLI` directory contains `ViVeTool.exe`.

This build targets **.NET Framework 4.8.1** and was checked on Windows 11 Pro 26H2, build `26300.9711`. The broader upstream minimum is not a promise that every feature works on every Windows edition.

## Validation and limits

- Chinese main window starts successfully after the startup fixes.
- Ten path-parser regression cases pass, including shallow paths, nested paths, ARM64 names, unrelated files, and diff patches.
- Read-only ViVe queries returned 4,511 runtime and 4,517 boot configurations on the test machine.
- The configuration change stamp was unchanged across the read-only checks.

**Feature writes and a complete scanner run have not been tested for this fork. IoT LTSC has not been tested.** There is no verified claim that this build restores the Settings Home page on IoT LTSC. Updating the core does not create a complete new 26H2 feature-ID catalogue; the build list and dictionary remain upstream data. A successful override does not prove that a feature exists or bypass edition/hardware requirements.

## Source and build

```text
ViVe/                         pinned ViVe library, CLI and dictionary source
vivetool-gui/                 maintained GUI source
ViVeTool-GUI.FeatureScanner/   maintained scanner source
Build.ps1                     restores packages and builds CLI, GUI and scanner
build-tools/verify-readonly.ps1
```

Install Visual Studio 2022 Build Tools with .NET desktop build tools and the .NET Framework 4.8.1 targeting pack. Run `./Build.ps1` from PowerShell. The script can also take `-MSBuildPath` and `-NuGetPath`. NuGet packages are restored during the build. The optional `PortableBuild.targets` supports the portable toolchain used for the original local build.

The GUI sources stay in their upstream directories; the pinned ViVe source is added under `ViVe/`. Original authorship and history remain available in Git. See the [development log](DEVELOPMENT_LOG.md) for implementation and validation details.

## Credits and licensing

- GUI and translations: [PeterStrick and contributors](https://github.com/PeterStrick/ViVeTool-GUI).
- ViVe core and ViVeTool CLI: [thebookisclosed / Albacore and contributors](https://github.com/thebookisclosed/ViVe).
- Feature lists and scanner tooling: [riverar/mach2](https://github.com/riverar/mach2).
- Icons: [Icons8](https://icons8.com/).

Original GPLv3 notices and license texts are retained in `LICENSE`, `ViVe/LICENSE`, and the original GUI copyright notices. **Telerik controls and other third-party dependencies keep their own licenses; they are not relicensed as GPL by this fork.** The GUI uses the Telerik assemblies supplied by the upstream repository. The design-time `.licx` exclusion follows [Telerik's documented build workaround](https://www.telerik.com/products/winforms/documentation/knowledge-base/kb-license-file-licx).

Changing Windows feature overrides can affect system behavior. Record the original state and only use feature IDs appropriate to your Windows build.
