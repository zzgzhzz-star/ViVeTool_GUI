param([string]$MSBuildPath, [string]$NuGetPath)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
if (-not $NuGetPath) {
    $NuGetPath = Join-Path $PSScriptRoot 'build-tools\nuget.exe'
    if (-not (Test-Path -LiteralPath $NuGetPath)) {
        New-Item -ItemType Directory -Force (Split-Path $NuGetPath) | Out-Null
        Invoke-WebRequest 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile $NuGetPath
    }
}
if (-not $MSBuildPath) {
    $command = Get-Command MSBuild.exe -ErrorAction SilentlyContinue
    if ($command) { $MSBuildPath = $command.Source }
    else {
        $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
        if (Test-Path -LiteralPath $vswhere) {
            $MSBuildPath = & $vswhere -latest -products '*' -requires Microsoft.Component.MSBuild -find 'MSBuild\**\Bin\MSBuild.exe' | Select-Object -First 1
        }
    }
}
$portable = $false
if (-not $MSBuildPath -and (Test-Path 'build-tools\msbuild\MSBuild.exe')) {
    $MSBuildPath = Join-Path $PSScriptRoot 'build-tools\msbuild\MSBuild.exe'
    $portable = $true
}
if (-not $MSBuildPath) { throw 'Install Visual Studio 2022 Build Tools with .NET desktop build tools and .NET Framework 4.8.1 targeting pack, or pass -MSBuildPath.' }
foreach ($config in @('ViVe\ViVeTool\packages.config', 'vivetool-gui\packages.config', 'ViVeTool-GUI.FeatureScanner\packages.config')) {
    $packages = if ($config.StartsWith('ViVe\')) { 'ViVe\packages' } else { 'packages' }
    & $NuGetPath restore $config -PackagesDirectory $packages -NonInteractive -Verbosity quiet
    if ($LASTEXITCODE -ne 0) { throw "Restore failed: $config" }
}
$common = @('/p:Configuration=Release', '/p:UseSharedCompilation=false', '/nr:false', '/nologo', '/v:minimal')
if ($portable) {
    $common += "/p:TargetFrameworkRootPath=$PSScriptRoot\build-tools\packages\Microsoft.NETFramework.ReferenceAssemblies.net481.1.0.3\build\"
    $common += @('/p:GenerateResourceMSBuildArchitecture=CurrentArchitecture', '/p:GenerateResourceMSBuildRuntime=CurrentRuntime')
}
& $MSBuildPath 'ViVe\ViVeTool\ViVeTool.csproj' @common
if ($LASTEXITCODE -ne 0) { throw 'ViVeTool CLI build failed.' }
$guiArgs = $common + @('/p:Platform=x64', '/p:OutputPath=bin\x64\Release\', '/p:AllowUnsafeBlocks=true')
if ($portable) { $guiArgs += '/p:PortableBuild=true' }
& $MSBuildPath 'vivetool-gui\ViVeTool_GUI.vbproj' @guiArgs
if ($LASTEXITCODE -ne 0) { throw 'ViVeTool GUI build failed.' }
Write-Output 'Build succeeded. GUI: vivetool-gui\bin\x64\Release\ViVeTool_GUI.exe'
