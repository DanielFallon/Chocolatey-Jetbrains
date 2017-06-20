. "$PSScriptRoot/../New-JetbrainsProduct.ps1" `
    -ProductName "Pycharm" `
    -DownloadUrl 'https://download.jetbrains.com/python/pycharm-community-$($version).exe' `
    -PackageId "Pycharm-Community" `
    -Title "Pycharm Community Edition" `
    -ProjectUrl "https://www.jetbrains.com/pycharm/" `
    -LicenseUrl "https://github.com/JetBrains/intellij-community/blob/master/LICENSE.txt" `
    -IconUrl "https://twitter.com/pycharm/profile_image?size=bigger" `
    -Tags "" `
    -Description @"
Python IDE for Professional Developers
Learn more at https://www.jetbrains.com/pycharm/
"@