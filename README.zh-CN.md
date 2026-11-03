# ViVeTool GUI — 非官方维护版

[English](README.md) · [中文开发日志](DEVELOPMENT_LOG.zh-CN.md) · [English development log](DEVELOPMENT_LOG.md) · [下载运行程序](https://github.com/zzgzhzz-star/ViVeTool_GUI/releases)

本项目 **fork 自 [PeterStrick/ViVeTool-GUI](https://github.com/PeterStrick/ViVeTool-GUI)**，接入更新的 [ViVe / ViVeTool 核心](https://github.com/thebookisclosed/ViVe)。这是独立维护构建，不是原作者或微软发布的新版本。

## 版本与来源

| 组件 | 版本／源码提交 |
|---|---|
| 本维护版 GUI | `1.7.0.1`，x64 |
| GUI 基础 | 上游 `v1.7-Testing`，`944b78ca16ede25d39f926d8994861d7aa95abcf` |
| ViVe 核心 | `2025.3.10.0`，上游 `master`，`3f8c6a3425983412da1e8b26cd757c3aa17b3f25` |
| 附带 ViVeTool CLI | `0.3.4` |
| 上游源码核对日期 | 2026-11-02 |

原 GUI 项目已经归档。这里用提交号说明实际使用的源码，并不宣称上游刚发布了新版。本 GitHub fork 保留了上游分支和提交历史。

## 本次修改

- GUI 改为从源码项目编译并引用更新的 ViVe 核心，不再使用内置的 2023 年 DLL。
- 附带单独编译的 ViVeTool 命令行程序及上游功能字典。
- 默认简体中文，保留上游语言资源和语言选择功能。
- 修复 `PopulateBuildComboBox()` 数组越界：不再假定 GitHub 功能列表路径具有固定层数。
- 修复 Release 编译、空功能列表、依赖绑定及 Sentry 未初始化时的释放异常。
- 修正变体参数写入，不再把变体编号同时写成外部 payload。
- 关闭归档项目的自动替换更新和已停用评论数据库的启动连接。
- 增加启动错误日志、构建脚本和只读回归检查。

## 下载与运行

从 [Releases](https://github.com/zzgzhzz-star/ViVeTool_GUI/releases) 下载 x64 运行包，**完整解压**，以管理员身份运行 `ViVeTool_GUI.exe`。请保留同目录 DLL、配置、语言和运行时子目录，不能只复制 EXE。`CLI` 文件夹中是 `ViVeTool.exe`。

本构建面向 **.NET Framework 4.8.1**，已在 Windows 11 专业版 26H2、`26300.9711` 上检查。上游更宽泛的最低系统要求不等于本维护版已验证所有 Windows 版本和功能。

## 已验证及限制

- 修复后的中文主界面能够正常启动。
- 10 项路径解析回归检查通过，覆盖浅层路径、深层路径、ARM64、无关文件及补丁文件。
- 在测试机读取到 4,511 条运行时配置和 4,517 条启动配置。
- 只读检查前后的配置 change stamp 一致，没有修改系统功能开关。

**尚未实测功能写入、扫描器的完整扫描，也未在 IoT LTSC 上运行验证。** 本构建不能保证恢复 IoT LTSC 的“设置主页”。更新核心不会自动生成完整的 26H2 功能 ID 名单，构建列表及字典仍来自上游数据。开关写入成功不代表对应功能存在，也不代表能绕过系统版本或硬件条件。

## 源码与编译

```text
ViVe/                         固定提交的 ViVe 核心、CLI 与字典源码
vivetool-gui/                 维护版 GUI 源码
ViVeTool-GUI.FeatureScanner/   维护版扫描器源码
Build.ps1                     还原依赖并编译 CLI、GUI 和扫描器
build-tools/verify-readonly.ps1
```

安装 Visual Studio 2022 Build Tools、.NET 桌面构建工具及 .NET Framework 4.8.1 targeting pack，在 PowerShell 中运行 `./Build.ps1`。可以通过 `-MSBuildPath` 和 `-NuGetPath` 指定工具路径。构建时会还原 NuGet 依赖。可选的 `PortableBuild.targets` 用于首次本地构建的便携工具链。

GUI 源码保留上游目录，固定版本的 ViVe 源码放入 `ViVe/`，原作者和提交历史保留在 Git 中。实现细节见[中文开发日志](DEVELOPMENT_LOG.zh-CN.md)。

## 致谢与许可证

- GUI 及翻译：[PeterStrick 与贡献者](https://github.com/PeterStrick/ViVeTool-GUI)。
- ViVe 核心与 CLI：[thebookisclosed / Albacore 与贡献者](https://github.com/thebookisclosed/ViVe)。
- 功能列表和扫描工具：[riverar/mach2](https://github.com/riverar/mach2)。
- 图标：[Icons8](https://icons8.com/)。

保留 GPLv3 版权声明及 `LICENSE`、`ViVe/LICENSE`及原 GUI 版权声明。**Telerik 控件及其他第三方依赖遵循各自许可证，本 fork 没有将它们重新授权为 GPL。** GUI 沿用上游仓库提供的 Telerik 程序集。设计期 `.licx` 的排除依据 [Telerik 官方构建说明](https://www.telerik.com/products/winforms/documentation/knowledge-base/kb-license-file-licx)。

修改 Windows 功能开关会影响系统行为。请记录原始状态，并使用与当前 Windows 构建相适配的功能 ID。
