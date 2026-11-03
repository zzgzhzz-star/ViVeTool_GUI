# ViVeTool GUI 1.7.0.1 — unofficial maintenance build / 非官方维护构建

## English

Based on PeterStrick/ViVeTool-GUI `v1.7-Testing` and thebookisclosed/ViVe master checked on 2026-11-02. Includes GUI 1.7.0.1, ViVe core 2025.3.10.0, ViVeTool CLI 0.3.4 and the upstream dictionary.

- Rebuilt against the updated ViVe core; Simplified Chinese is the default.
- Fixed the startup build-list `IndexOutOfRangeException`, dependency binding, Release compilation, empty-list handling and Sentry disposal.
- Corrected variant payload defaults; disabled the archived updater and retired comments service startup connection.
- Added bilingual documentation, development logs and read-only regression checks.

Extract the complete x64 runtime ZIP and run `ViVeTool_GUI.exe` as administrator. Do not copy the EXE alone. Source is available in the repository and the source ZIP; checksums are provided separately.

Validated Chinese startup and 10 parser cases on Windows 11 Pro 26H2 / 26300.9711. Read-only queries returned 4,511 runtime and 4,517 boot records with an unchanged configuration stamp. Feature writes, a complete scanner run and IoT LTSC have not been tested. This release does not promise to restore Settings Home or provide a complete 26H2 ID list.

## 简体中文

基于 2026-11-02 核对的 PeterStrick/ViVeTool-GUI `v1.7-Testing` 与 thebookisclosed/ViVe master。包含 GUI 1.7.0.1、ViVe 核心 2025.3.10.0、ViVeTool CLI 0.3.4 及上游字典。

- 使用更新的 ViVe 核心重新编译，默认简体中文。
- 修复启动构建列表数组越界、依赖绑定、Release 编译、空列表及 Sentry 释放问题。
- 修正变体 payload 默认写入；关闭归档更新器及已停用评论服务的启动连接。
- 增加中英文说明、开发日志和只读回归检查。

完整解压 x64 运行包，以管理员身份运行 `ViVeTool_GUI.exe`，不要只复制 EXE。仓库及源码 ZIP 提供源码，附有独立校验文件。

已在 Windows 11 专业版 26H2 / 26300.9711 验证中文启动和 10 项解析检查。只读查询得到 4,511 条运行时和 4,517 条启动配置，检查前后配置标记一致。尚未测试功能写入、完整扫描及 IoT LTSC；不能保证恢复设置主页，也不代表具有完整的 26H2 功能 ID 列表。

## Credits / 来源与许可

Forked from [PeterStrick/ViVeTool-GUI](https://github.com/PeterStrick/ViVeTool-GUI), using [thebookisclosed/ViVe](https://github.com/thebookisclosed/ViVe), [riverar/mach2](https://github.com/riverar/mach2), and upstream translations/icons. Original GPLv3 notices are retained. Third-party components, including Telerik controls, retain their own licenses. This is an unsigned, unofficial build.

fork 自上述 GUI 项目，使用 ViVe、mach2 及上游翻译和图标。保留原 GPLv3 声明；Telerik 等第三方组件遵循各自许可。本构建非官方且未签名。

Publication verification / 发布前复核 (2026-11-03): repository-layout rebuild passed; 10 parser cases passed; 4,513 runtime and 4,517 boot records read, configuration stamp unchanged. See validation.json. / 仓库布局重编译及 10 项解析检查通过，读取 4,513／4,517 条配置，前后配置标记一致，详见 validation.json。

