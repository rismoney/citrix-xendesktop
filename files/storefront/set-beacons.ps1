#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "set-beacons.log"
start-transcript -path $logfile -noclobber

# Setting up Internal Beacon
$BeaconID = [System.Guid]::NewGuid().ToString()
Set-DSGlobalInternalBeacon -BeaconId $BeaconID -BeaconAddress $InternalBeacon
Write-Host "Internal Beacon has been set to $InternalBeacon" -foregroundcolor "Green"

# Setting up External Beacons
$BeaconsDTOExternal = @()
ForEach ($Beacon in $ExternalBeacons)
{
    $BeaconDTO = New-Object Citrix.DeliveryServices.Admin.RoamingModel.DTO.BeaconDTO
    $BeaconDTO.Address = $Beacon
    $BeaconsDTOExternal += @($BeaconDTO)
}
Set-DSGlobalExternalBeacons -Beacons $BeaconsDTOExternal

Write-Host "External Beacons have been set to $ExternalBeacons" -foregroundcolor "Green"

stop-transcript
