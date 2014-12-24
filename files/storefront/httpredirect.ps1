import-module webAdministration
# Set Powershell Compatibility Mode
Set-StrictMode -Version 2.0

# Any failure is a terminating failure.
$ErrorActionPreference = 'Stop'

#create logging folder
$logpath = "C:\@inf\winbuild\logs\citrix"
mkdir $logpath -force

$logfile = join-path $logpath "httpredirect.log"
start-transcript -path $logfile -noclobber

$siteName = "Default Web Site"
$redirectPage = "http://storefront.example.com/StoreWeb"

# Set the redirect
Set-WebConfiguration system.webServer/httpRedirect "IIS:\sites\$siteName" -Value @{enabled="true";destination="$redirectPage";exactDestination="true";httpResponseStatus="Found"}

# Disable the redirect
#Set-WebConfiguration system.webServer/httpRedirect "IIS:\sites\$siteName" -Value @{enabled="false"}

stop-transcript
