#dotsource delivery controller and licensing configurations
. .\dcconfig.ps1
. .\licconfig.ps1

# Set Powershell Compatibility Mode
Set-StrictMode -Version 2.0

# Any failure is a terminating failure.
$ErrorActionPreference = 'Stop'

#create logging folder
mkdir $logpath -force

$logfile = join-path $logpath "initialize-site.log"
start-transcript -path $logfile -noclobber

# Add-PSSnapin Citrix.*
import-module -name Citrix.Xendesktop.Admin -Verbose

$DatabasePassword = $DatabasePassword | ConvertTo-SecureString -asPlainText -Force
$Database_CredObject = New-Object System.Management.Automation.PSCredential($DatabaseUser,$DatabasePassword)

Add-PSSnapin Citrix.*
New-XDDatabase -AdminAddress $env:COMPUTERNAME -SiteName $XD7Site -DataStore Site -DatabaseServer $DatabaseServer -DatabaseName $DatabaseName_Site -DatabaseCredentials $Database_CredObject
New-XDDatabase -AdminAddress $env:COMPUTERNAME -SiteName $XD7Site -DataStore Logging -DatabaseServer $DatabaseServer -DatabaseName $DatabaseName_Logging -DatabaseCredentials $Database_CredObject
New-XDDatabase -AdminAddress $env:COMPUTERNAME -SiteName $XD7Site -DataStore Monitor -DatabaseServer $DatabaseServer -DatabaseName $DatabaseName_Monitor -DatabaseCredentials $Database_CredObject

New-XDSite -AdminAddress $env:COMPUTERNAME -SiteName $XD7Site -DatabaseServer $DatabaseServer -LoggingDatabaseName $DatabaseName_Logging -MonitorDatabaseName $DatabaseName_Monitor -SiteDatabaseName $DatabaseName_Site

#wtf licensing cmdlets missing from Citrix.Xendesktop.Admin

import-module .\Citrix.Configuration.PowerShellSnapIn.dll -verbose
import-module .\Citrix.LicensingAdmin.PowershellSnapIn.dll -verbose

Set-ConfigSite  -AdminAddress $env:COMPUTERNAME `
                -LicenseServerName $LicenseServer `
                -LicenseServerPort $LicenseServer_Port `
                -LicensingModel $LicenseServer_LicensingModel `
                -ProductCode $LicenseServer_ProductCode `
                -ProductEdition $LicenseServer_ProductEdition `
                -ProductVersion $LicenseServer_ProductVersion `

$LicenseServer_AdminAddress = Get-LicLocation -AddressType $LicenseServer_AddressType `
                                              -LicenseServerAddress $LicenseServer
                                              -LicenseServerPort $LicenseServer_Port

$LicenseServer_CertificateHash = $(Get-LicCertificate  -AdminAddress $LicenseServer_AdminAddress).CertHash
Set-ConfigSiteMetadata  -AdminAddress $env:COMPUTERNAME -Name "CertificateHash" -Value $LicenseServer_CertificateHash
