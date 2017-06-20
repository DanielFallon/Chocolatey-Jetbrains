$ErrorActionPreference  = 'Stop'

$arguments              = @{
    packageName         =  "$env:chocolateyPackageName"
}
$JetbrainsDefaults = @{

    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0)
}
$JetbrainsAutoArgs = @{
    url                 = 'https://download.jetbrains.com/.exe'
    checksum            = 'ddd95365b4a10586cab85a4f976387d37987f91905ae96b2c1f800cba4d2a3fb'
}
Install-ChocolateyPackage @arguments @JetbrainsDefaults @JetbrainsAutoArgs
