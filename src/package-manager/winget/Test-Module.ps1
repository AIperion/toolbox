Remove-Module -Name Install-Packages
Import-Module .\Install-Packages.psm1

Install-Packages -ConfigFile .\winget-config.json -InstallAllPackages