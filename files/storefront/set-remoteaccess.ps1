#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "set-remoteaccess.log"
start-transcript -path $logfile -noclobber

# Enable Remote Access
$StoreSummary = Get-DSStoreServiceSummary -siteId $SiteID -virtualPath $StoreVirtualPath
$ServiceDTO = [Citrix.DeliveryServices.Admin.RoamingModel.Utilities.StoreServiceUtilities]::CreateStoreServiceDto($StoreSummary)

if ((Get-DSGlobalAccounts).Accounts.RemoteAccessType -eq "None") {
  Set-DSGlobalAccountRemoteAccess -ServiceRef $ServiceDTO.ServiceRef -RemoteAccessType $StoreRemoteAccessType
  write-host "set $storeremoteaccesstype on store"
}
else {
  write-host "already set $storeremoteaccesstype on store"
}

# Set Gateways to be used by Store Services
$GatewayDTO = (Get-DSGlobalGateways).Gateways | Where {$_.Name -eq $GatewayName}
#$Gateway2DTO = (Get-DSGlobalGateways).Gateways | Where {$_.Name -eq $Gateway2Name}
#$Gateway3DTO = (Get-DSGlobalGateways).Gateways | Where {$_.Name -eq $Gateway3Name}

if (-not (Get-DSGlobalServicesUsingGateways)) {
  Set-DSGlobalServiceGateways  -ServiceRef $ServiceDTO.ServiceRef -Gateways @($GatewayDTO)
  #Set-DSGlobalServiceGateways  -ServiceRef $ServiceDTO.ServiceRef -Gateways @($Gateway2DTO,$Gateway3DTO)
  write-host "set $gatewayname on store"
}
else {
  write-host "$gatewayname already set"
}

stop-transcript