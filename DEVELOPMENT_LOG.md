# Development log

[简体中文](DEVELOPMENT_LOG.zh-CN.md)

## 2026-11-02 — 1.7.0.1 maintenance build

### Baseline and integration

Cloned both upstream repositories and pinned the revisions documented in the README. Selected the GUI's `v1.7-Testing` branch because it contains the newer ViVe API integration and translated resources; the archived default branch still uses the older API. Replaced the bundled `Albacore.ViVe` reference with a project reference to the pinned current core. Built CLI `0.3.4` separately and included the upstream feature dictionary.

### Build and dependency work

The development machine had a modern .NET SDK but lacked a complete Visual Studio/.NET Framework desktop build environment. Assembled a local portable MSBuild/Roslyn toolchain and .NET Framework 4.8.1 reference assemblies. Added optional Roslyn satellite-resource generation where `al.exe` is unavailable. Excluded the design-time Telerik `.licx` build input according to the vendor's documented workaround; third-party binaries and licensing mechanisms were not patched.

Fixed a Release build error caused by a variable declared only under `DEBUG` but referenced outside it. Removed a duplicate RuntimeInformation reference supplied by the target framework. Updated System.Text.Json to `8.0.6`, MySqlConnector to `2.4.0`, and matching logging/dependency-injection abstractions to `8.0.2`. Enabled generated binding redirects and removed conflicting stale redirects. Added a bootstrap entry point and local startup exception logging.

### Runtime fixes

An initial startup attempt failed. After dependency fixes, startup reached the UI but showed `IndexOutOfRangeException` from `PopulateBuildComboBox()`. The upstream parser indexed a fixed fourth path component. Extracted `BuildListParser.GetBuildName()` to validate numeric `.txt` build filenames without assuming a fixed directory depth, and ignore unrelated files/diff patches. Added a guard for an empty auto-load list and corrected the architecture `Select Case` alternatives.

Handled null feature-configuration arrays and empty grids. Guarded disposal when Sentry was not initialized. Retained the placeholder/disabled telemetry configuration rather than assigning a maintainer endpoint. Removed startup calls to the retired comments service and the upstream updater that could replace this custom build. Aligned variant writes with the CLI's default payload semantics.

### Verification evidence

| Check | Result |
|---|---|
| Final Release build | Successful; final captured build log contained no warnings/errors |
| Chinese GUI startup | Main window visibly opened; the reported path-parser exception no longer appeared |
| Parser regression cases | 10/10 passed |
| Runtime configuration enumeration | 4,511 records on the test machine |
| Boot configuration enumeration | 4,517 records on the test machine |
| Configuration change stamp | Unchanged before/after the read-only checks |
| Packaged files | GUI, ViVe DLL, Chinese satellite DLL, CLI and dictionary checked in ZIP |

Test environment: Windows 11 Pro 26H2, OS build `26300.9711`. Enumeration counts are machine-specific, not universal expected values. No feature was enabled, disabled, or reset during testing. Function-write behavior, an end-to-end scanner run, other Windows builds, and IoT LTSC remain unverified.

### Publication

Created a GitHub fork under `zzgzhzz-star/ViVeTool_GUI`, preserving upstream attribution/history. Prepared bilingual README/development logs, source snapshots, a runtime ZIP, and SHA-256 checksums. The pinned ViVe source is added under `ViVe/`, while GUI source remains in its upstream directories; the layout adaptation does not change feature behavior. Published binaries are local, unsigned maintenance builds, not an upstream certification or an official Microsoft package.
