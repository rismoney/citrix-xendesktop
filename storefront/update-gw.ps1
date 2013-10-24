#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "update-gw.log"
start-transcript -path $logfile -noclobber

Write-Host "--------------------------------------------------------------------------------" -foregroundcolor "Yellow"
Write-Host "Updating Gateways" -foregroundcolor "Yellow"
Write-Host "--------------------------------------------------------------------------------" -foregroundcolor "Yellow"

$GatewaysDTO = (Get-DSGlobalGateways).Gateways

ForEach ($GatewayDTO in $GatewaysDTO)
{
    $ExDTO = New-object Citrix.DeliveryServices.Admin.RoamingModel.DTO.ExtendedGatewayDTO
    $ExDTO.ID = $GatewayDTO.ID
    $ExDTO.AccessGatewayVersion = $GatewayDTO.AccessGatewayVersion
    $ExDTO.Name = $GatewayDTO.Name
    $ExDTO.Address = $GatewayDTO.Address
    #$gwExDTO.Edition = $GatewayDTO.Edition
    $ExDTO.Default = $GatewayDTO.Default
    $ExDTO.DeploymentType = $GatewayDTO.Deployment
    $ExDTO.Logon = $GatewayDTO.Logon
    $ExDTO.CallbackURL = $GatewayDTO.CallbackURL
    $ExDTO.IPAddress = $GatewayDTO.IPAddress
    $ExDTO.SessionReliability = $GatewayDTO.SessionReliability
    $ExDTO.RequestTicketTwoSTA = $GatewayDTO.RequestTicketTwoSTA
    $ExDTO.SecureTicketAuthorityURLs = New-Object 'System.Collections.Generic.List[String]'
    $StaURL = $GatewayDTO.SecureTicketAuthorityURLs
    $ExDTO.SecureTicketAuthorityURLs.Add($StaURL) #Change this

    $GatewayCluster += [Citrix.DeliveryServices.Admin.Authentication.Extensions.CitrixAGBasicExtension.CitrixAGBasicExtension]::ConvertToAuthFormat($ExDTO)
}

# Update Gateways
Update-DSCitrixAGBasicGateways -SiteId $SiteID -VirtualPath $AuthenticationVirtualPath -Clusters $GatewayCluster
Write-Host "AG Basic Gateways have been updated." -foregroundcolor "Green"

stop-transcript