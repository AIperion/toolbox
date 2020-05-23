function Test-Parameters($packages, $installAllPackages, $configFile){
    if(-not $packages -and -not $installAllPackages){
        Write-Error "Specify -Package/-p parameter for list of packages (e.g. -p Package1,PAckage2), which should be installed.`n`r`
        Alternative it possible to install all packages by setting -InstallAllPackages/-a parameter." -ErrorAction Stop;
    }

    if(-not (Test-Path -Path $configFile)){
        Write-Error "Can not find config file '$configFile'. Please check the path" -ErrorAction Stop
    }
}
function Install-Packages {
    Param(
        [Parameter(Mandatory = $true)]
        [Alias("c")]
        [string] $ConfigFile,
        [Parameter(Mandatory = $false)]
        [Alias("p")]
        [array]
        $Packages,
        [Parameter(Mandatory = $false)]
        [Alias("a")]
        [switch]
        $InstallAllPackages
    )

    $scriptDir =  Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $schemaFile = Join-Path $scriptDir "schema.json" 

    # Validate Module parameters
    Test-Parameters $Packages $InstallAllPackages $ConfigFile

    #Check for valid json configuration
    Test-Json -Json (Get-Content -Path $ConfigFile -Raw) -Schema (Get-Content -Path $schemaFile -Raw) -ErrorAction Stop

    #Read configuration file
    $configAsString = Get-Content -Path $ConfigFile -Raw
    $config = ConvertFrom-Json $configAsString

    $packageDefinitions = $config.packages 

    foreach ($definition in $packageDefinitions) {
        
        if((-not $InstallAllPackages) -and !($Packages -contains $definition.name)){
            continue;
        }
        
        foreach ($app in $definition.applications) {
            
            $parameters = " --id $($app.id) -e -h"
            if($app.version){
                $parameters = "$parameters -v $($app.version)"
            }
            
            & winget "install" $parameters.Split(" ")  
        }   
    }
}

Export-ModuleMember -Function Install-Packages  