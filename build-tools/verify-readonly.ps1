param([string]$PackagePath)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$package = if ($PackagePath) { (Resolve-Path -LiteralPath $PackagePath).Path } else { Join-Path $root 'artifacts\ViVeTool-GUI-Latest-x64' }
$gui = [Reflection.Assembly]::LoadFrom((Join-Path $package 'ViVeTool_GUI.exe'))
$parser = $gui.GetType('ViVeTool_GUI.BuildListParser', $true).GetMethod('GetBuildName')
$cases = @(
    @('features/ge_release/amd64/26100.txt', '26100'),
    @('features/branch/26100.1.txt', '26100.1'),
    @('features/branch/arm64/26300.9711_arm64.txt', '26300.9711_arm64'),
    @('features/26300.txt', '26300'),
    @('features.txt', $null),
    @('README.md', $null),
    @('features/branch/26100_26200_diff.patch', $null),
    @('features/branch/features.txt', $null),
    @('docs/26300.txt', $null),
    @('', $null)
)
foreach ($case in $cases) {
    $actual = $parser.Invoke($null, @($case[0]))
    if ($actual -cne $case[1]) { throw "Path regression failed: $($case[0]) -> $actual" }
}
[Reflection.Assembly]::LoadFrom((Join-Path $package 'Albacore.ViVe.dll')) | Out-Null
$stampBefore = [Albacore.ViVe.FeatureManager]::QueryFeatureConfigurationChangeStamp()
$runtime = [Albacore.ViVe.FeatureManager]::QueryAllFeatureConfigurations([Albacore.ViVe.NativeEnums.RTL_FEATURE_CONFIGURATION_TYPE]::Runtime)
$boot = [Albacore.ViVe.FeatureManager]::QueryAllFeatureConfigurations([Albacore.ViVe.NativeEnums.RTL_FEATURE_CONFIGURATION_TYPE]::Boot)
$stampAfter = [Albacore.ViVe.FeatureManager]::QueryFeatureConfigurationChangeStamp()
$satellite = [Reflection.Assembly]::LoadFrom((Join-Path $package 'zh\ViVeTool_GUI.resources.dll'))
$resourceNames = $satellite.GetManifestResourceNames()
if ($resourceNames -notcontains 'ViVeTool_GUI.GUI.zh.resources') { throw 'Chinese GUI resources missing.' }
[pscustomobject]@{
    ParserCasesPassed = $cases.Count
    RuntimeConfigurations = @($runtime).Count
    BootConfigurations = @($boot).Count
    FeatureConfigurationStampUnchanged = ($stampBefore -eq $stampAfter)
    CoreVersion = [Albacore.ViVe.FeatureManager].Assembly.GetName().Version.ToString()
    GuiVersion = $gui.GetName().Version.ToString()
    ChineseResources = $resourceNames
} | ConvertTo-Json -Depth 4
