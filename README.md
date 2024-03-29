# Winget Packages
This small PowerShell module provides a tooling to install applications via winget as predfined packages. 
The packages are define as a simple JSON configuration file like the example in the configuration section. 

## Confguration
The configuration schema is able to define multiple packages and each package combines multiple apps for installation via the PowerShell module.

``` JSON
{
    "$schema": "./schema.json",
    "packages": [
        {
            "name": "General",
            "applications": [
                {
                    "id": "7zip.7zip"
                },
                {
                    "id": "DominikReichl.KeePass"
                },
                {
                    "id": "Microsoft.Edge"
                }
            ]
        },
        {
            "name": "Development",
            "applications": [
                {
                    "id": "Git.Git"
                },
                {
                    "id": "Microsoft.VisualStudio.Enterprise"
                },
                {
                    "id": "Microsoft.VisualStudioCode"
                }
            ]
        }
    ]
}
```
Full example can be find in the [winget-config.json](./src/package-manager/winget/winget-config.json) file and a json schema defintion is can be found in the [schema.json](src/package-manager/winget/schema.json) file.

## Install Module
Module can be installed like every other PowerShell module:
``` PowerShell
Import-Module ./Install-Packages.psm1
```

## Use Module

There are two options to install the packages from the config.

Option 1 is to install all defined packages by using the follwing command:
``` PowerShell
Install-Packages -ConfigFile .\winget-config.json -InstallAllPackages
```

Option 2 is to select the packages by name:
``` PowerShell
Install-Packages -ConfigFile .\winget-config.json -Packages "General"
```