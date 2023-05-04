Param(
    [Parameter(Mandatory=$false)]
    [Switch] $businessPackages = $false,
    [Parameter(Mandatory=$false)]
    [Switch] $privatePackages = $false,
    [Parameter(Mandatory=$false)]
    [Switch] $devPackages = $false,
    [Parameter(Mandatory=$false)]
    [Switch] $extendedDevPackages = $false
)

$PackagesGeneral = @("firefox" , "7zip.install","notepadplusplus.install","vlc", "keepass.install", "powertoys", "powershell-core", "microsoft-teams")
$PackagesPrivate = @("trillian", "gimp", "Calibre")
$PackagesDev = @("git.install", "vscode", "dotnetcore-sdk","postman", "beyondcompare", "microsoftazurestorageexplorer")
$PackagesDevExtended = @("yarn", "putty.install", "kubernetes-helm", "yo")


$packagesToInstall = $PackagesGeneral

Switch ($PSBoundParameters.GetEnumerator().Where({$_.Value -eq $true}).Key)
{
   'businessPackages'{ $packagesToInstall += $PackagesBusiness }
   'privatePackages' { $packagesToInstall += $PackagesPrivate  }
   'devPackages'     { $packagesToInstall += $PackagesDev }
   'extendedDevPackages' { $packagesToInstall += $PackagesDevExtended}
}

foreach ($package in $packagesToInstall) 
{
    choco install $package -y
}