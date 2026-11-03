# 开发日志

[English](DEVELOPMENT_LOG.md)

## 2026-11-02 — 1.7.0.1 维护构建

### 基线与核心集成

拉取两个上游仓库，并固定 README 中记录的提交。GUI 选择 `v1.7-Testing` 分支，因为它包含较新的 ViVe API 集成及多语言资源；已归档的默认分支仍使用旧 API。将内置 `Albacore.ViVe` DLL 引用替换为当前核心源码项目引用，单独编译 CLI `0.3.4`，附带上游功能字典。

### 构建与依赖处理

开发机已有现代 .NET SDK，但缺少完整的 Visual Studio/.NET Framework 桌面构建环境。因此在本地工作目录组装便携 MSBuild、Roslyn 和 .NET Framework 4.8.1 引用程序集，并增加缺少 `al.exe` 时由 Roslyn 生成语言资源 DLL 的可选构建支持。依据厂商文档排除 Telerik 设计期 `.licx` 构建输入，没有修改第三方二进制或其许可机制。

修复仅在 `DEBUG` 下声明变量、却被其他代码引用导致的 Release 编译失败；移除目标框架已提供的重复 RuntimeInformation 引用。将 System.Text.Json 更新为 `8.0.6`、MySqlConnector 更新为 `2.4.0`，同步 logging/dependency-injection abstractions 为 `8.0.2`。启用自动生成程序集绑定重定向，移除冲突的旧配置。增加启动入口包装和本地启动异常日志。

### 运行时修复

首次启动失败。处理依赖后，程序进入界面，但 `PopulateBuildComboBox()` 报出 `IndexOutOfRangeException`。原因是上游解析器直接读取固定的第四层路径。抽取 `BuildListParser.GetBuildName()`，只校验数字构建名 `.txt` 文件，不再依赖固定目录深度，并忽略无关文件及 diff 补丁。增加自动加载列表为空时的保护，修正架构 `Select Case` 的分支写法。

处理空功能配置数组和空表格，防止 Sentry 未初始化时释放空对象。保持遥测配置为上游占位／关闭状态，没有设置维护者收集端点。移除启动时对已停用评论服务和可能覆盖定制构建的上游自动更新器的调用。将变体参数写入调整为与 CLI 默认 payload 语义一致。

### 验证记录

| 检查 | 结果 |
|---|---|
| 最终 Release 编译 | 成功；最终记录的构建日志没有警告或错误 |
| 中文 GUI 启动 | 主窗口实际打开，未再出现已报告的路径越界异常 |
| 路径解析回归 | 10/10 通过 |
| 运行时配置枚举 | 测试机 4,511 条 |
| 启动配置枚举 | 测试机 4,517 条 |
| 配置 change stamp | 只读检查前后一致 |
| 压缩包检查 | 核对 GUI、ViVe DLL、中文资源 DLL、CLI 及字典 |

测试环境：Windows 11 专业版 26H2，OS 内部版本 `26300.9711`。枚举数量取决于机器，不是统一的预期值。测试期间没有启用、禁用或重置任何功能。功能写入、扫描器完整运行、其他 Windows 构建及 IoT LTSC 均尚未验证。

### 发布整理

在 `zzgzhzz-star/ViVeTool_GUI` 创建 GitHub fork，保留上游来源与历史。整理中英文 README、开发日志、源码快照、运行包及 SHA-256 校验信息。固定版本的 ViVe 源码新增到 `ViVe/`，GUI 保留上游目录；目录适配不改变程序的功能行为。发布程序是本地编译、未签名的维护构建，不代表上游认证或微软官方发行。
