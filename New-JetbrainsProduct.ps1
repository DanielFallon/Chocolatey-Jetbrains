Param(
# Auto Update Settings
$ProductName,
$DownloadUrl,
$UpdateUrl = 'https://jetbrains.com/updates/updates.xml',

# Package Description Settings
$PackageId,
$Title,
$ProjectUrl,
$LicenseUrl,
$IconUrl,
$Tags,
$Description
)

$NuspecXml = @"
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">
  <metadata>
    <id>$PackageId</id>
    <version>0.0.0.0</version>
    <title>$Title</title>
    <owners>Daniel Fallon</owners>
    <authors>Jetbrains</authors>
    <projectUrl>$ProjectUrl</projectUrl>
    <licenseUrl>$LicenseUrl</licenseUrl>
    <iconUrl>$IconUrl</iconUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>
$Description
    </description>
    <releaseNotes></releaseNotes>
    <packageSourceUrl>https://github.com/DanielFallon/Chocolatey-Jetbrains</packageSourceUrl>
    <tags>$Tags</tags>
    <dependencies>
      <dependency id="chocolatey-core.extension" version="1.2.0" />
    </dependencies>
  </metadata>
  <files>
    <file src="tools\**" target="tools" />
  </files>
</package>
"@

$UpdateVarScript = @"
`$env:CHOCOLATEY_JETBRAINS_PRODUCT_NAME = '$ProductName'
`$env:CHOCOLATEY_JETBRAINS_DOWNLOAD_URL = '$DownloadUrl'
`$env:CHOCOLATEY_JETBRAINS_UPDATE_URL = '$UpdateUrl'
"@

$TemplateFolder = (Join-Path $PSScriptRoot "Template")
$PackageFolder = (Join-Path $PSScriptRoot "$PackageId")

New-Item -ItemType Directory -Path $PackageFolder -Force | Out-Null
Copy-Item -Recurse -Force -Path (Join-Path $TemplateFolder  "*" ) -Destination $PackageFolder 
$UpdateVarScript | Out-File -Force -Encoding ascii -FilePath (Join-Path $PackageFolder "update-vars.ps1") 
$NuspecXml | Out-File -Force -Encoding ascii -FilePath (Join-Path $PackageFolder "$PackageID.nuspec")

Push-Location $PackageFolder
& "./update.ps1"
Pop-Location