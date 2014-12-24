#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "add-auth.log"
start-transcript -path $logfile -noclobber

# Add Authentication Protocols

$protocols=(Get-DSAuthenticationServicesSummary).protocols #|select choice
$comparison=compare-object $AuthenticationProtocols $protocols.choice
if ($comparison) {
  Set-DSAuthenticationProtocolsDeployed -SiteId $SiteID -VirtualPath $AuthenticationVirtualPath -Protocols $AuthenticationProtocols
  Write-Host "Added AuthenticationProtocols: $AuthenticationProtocols" -foregroundcolor "Green"
}
else {
  Write-Host "AuthenticationProtocols: $AuthenticationProtocols already exist" -foregroundcolor "Yellow"
}

stop-transcript
