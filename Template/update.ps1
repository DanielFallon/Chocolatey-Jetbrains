Import-Module AU
. (Join-Path $PSScriptRoot "update-vars.ps1")
function global:au_GetLatest {
    Write-Host $env:CHOCOLATEY_JETBRAINS_UPDATE_URL
    Write-Host $env:CHOCOLATEY_JETBRAINS_DOWNLOAD_URL
    Write-Host $env:CHOCOLATEY_JETBRAINS_PRODUCT_NAME
    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($env:CHOCOLATEY_JETBRAINS_UPDATE_URL)
    $versionInfo = $updates.products.product `
        | Where-Object { $_.name -eq $env:CHOCOLATEY_JETBRAINS_PRODUCT_NAME } `
        | ForEach-Object { $_.channel } `
        | ForEach-Object { $_.build } `
        | Sort-Object { [version] $_.fullNumber } `
        | Where-Object { $_.version -notmatch 'EAP' } `
        | Select-Object -Last 1

    $version = $versionInfo.Version
    if (-Not ($version -match '\d+\.\d+')) {
        $version = "$($version).$($versionInfo.ReleaseDate)"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($env:CHOCOLATEY_JETBRAINS_DOWNLOAD_URL)

    return @{ Url32 = $downloadUrl; Version = $version }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

Update -ChecksumFor 32