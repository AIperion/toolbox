$scriptDir =  Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$modulePath = Join-Path $scriptDir "Install-Packages.psm1"
$configFilePath = Join-Path $scriptDir "winget-config.json"

Remove-Module -Name Install-Packages -ErrorAction SilentlyContinue
Import-Module $modulePath

#Install-Packages -ConfigFile $configFilePath -InstallAllPackages
Install-Packages -ConfigFile $configFilePath -Packages "General"