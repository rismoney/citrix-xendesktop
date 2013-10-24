#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "add-agee.log"
start-transcript -path $logfile -noclobber

# AGEE Parameters
function agee {
  param(
    [string]$GatewayName,
    [string]$GatewayURL,
    [String]$LogonType,
    [String]$CallBackURL,
    [String]$SubnetIPAddress,
    $SessionReliability,
    $RequestTicketTwoSTA,
    [String]$STAURL,
    [string]$XenMobileSTA
  )

  $gwDTO = New-object Citrix.DeliveryServices.Admin.RoamingModel.DTO.ExtendedGatewayDTO
  $gwDTO.AccessGatewayVersion = [Citrix.DeliveryServices.Admin.RoamingModel.DTO.AccessGatewayVersion]::Version10_0_69_4
  $gwDTO.Name = $GatewayName
  $gwDTO.Address = $GatewayURL
  $gwDTO.Default = $False
  $gwDTO.DeploymentType = [Citrix.DeliveryServices.Admin.RoamingModel.DTO.DeploymentMode]::Appliance
  $gwDTO.Logon = $LogonType
  $gwDTO.CallbackURL = $CallBackURL
  $gwDTO.IPAddress = $SubnetIPAddress
  $gwDTO.SessionReliability = $SessionReliability
  $gwDTO.RequestTicketTwoSTA = $RequestTicketTwoSTA
  $gwDTO.SecureTicketAuthorityURLs = New-Object 'System.Collections.Generic.List[String]'
  $gwDTO.SecureTicketAuthorityURLs.Add($STAURL)
  # $gwDTO.SecureTicketAuthorityURLs.Add($XenMobileSTA)

  # Add AGEE
  $ExistingGateways=Get-DSGlobalGateways
  if ($ExistingGateways.gateways.count -eq 0 -or $ExistingGateways.gateways.name -notcontains($GatewayName)) {
    Add-DSGlobalV10Gateway  -Id $gwDTO.ID `
                            -Name $gwDTO.Name `
                            -Address $gwDTO.Address `
                            -IsDefault $gwDTO.Default `
                            -CallbackUrl $gwDTO.CallbackURL `
                            -SessionReliability $gwDTO.SessionReliability `
                            -RequestTicketTwoSTA $gwDTO.RequestTicketTwoSTA `
                            -SecureTicketAuthorityUrls $gwDTO.SecureTicketAuthorityURLs `
                            -Logon $gwDTO.Logon `
                            -SmartCardFallback "None" `
                            -IPAddress $gwDTO.IPAddress

    Write-Host "Access Gateway:$GatewayName has been added" -foregroundcolor "Green"
  }
  else {
    Write-Host "Access Gateway:$GatewayName already exists" -foregroundcolor "Yellow"
  }
}

agee -GatewayName $GatewayName `
     -GatewayURL $GatewayURL `
     -LogonType $LogonType `
     -CallBackURL $CallBackURL `
     -SubnetIPAddress $SubnetIPAddress `
     -SessionReliability $SessionReliability `
     -RequestTicketTwoSTA $RequestTicketTwoSTA `
     -STAURL $STAURL `
     -XenMobileSTA $XenMobileSTA

stop-transcript
