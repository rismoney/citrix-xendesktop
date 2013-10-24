#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "initialize-sf.log"
start-transcript -path $logfile -noclobber


Write-host "--------------------------------------------------------------------------------" -foregroundcolor "Green"
Write-host "Initial StoreFront Configuration" -foregroundcolor "Yellow"
Write-host "--------------------------------------------------------------------------------" -foregroundcolor "Green"

# if a cluster is setup never do an initial configuration

$HostBaseUrl
$FarmName 
$FarmType
$FarmServers
$HTTPSport
$SSLRelayPort
$LoadBalancing
# $AuthenticationVirtualPath
# $StoreVirtualPath
# $WebReceiverVirtualPath
# $DesktopApplianceVirtualPath
# $RoamingVirtualPath

if (-Not (Get-DSClusterId)) {
  Set-DSInitialConfiguration -hostBaseUrl $HostBaseUrl `
                             -farmName $FarmName `
                             -farmType $FarmType `
                             -servers $FarmServers `
                             -port $HTTPSport `
                             -transportType HTTPS `
                             -sslRelayPort $SSLRelayPort `
                             -loadBalance $LoadBalancing
}

stop-transcript
