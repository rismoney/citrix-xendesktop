# -------------------------------------------
# Do not modify this section!!!
# Scaffold of First Delivery Controller
# Will be Overwritten Later by Add-Farms.ps1
# -------------------------------------------

[String]$HostBaseUrl = "https://storefront.example.com"
[String]$FarmName = "ISEFarm1"
[String]$FarmType = "XenDesktop"
[String]$FarmServers = "xendesktopa.example.com"
[Int]$HTTPport = 80
[Int]$HTTPSport = 443
[Int]$SSLRelayPort = 443
$LoadBalancing = $false
[String]$AuthenticationVirtualPath = "/Citrix/Authentication"
[String]$StoreVirtualPath = "/Citrix/Storefront"
[String]$WebReceiverVirtualPath = "/Citrix/StorefrontWeb"
[String]$DesktopApplianceVirtualPath = "/Citrix/DesktopAppliance"
[String]$RoamingVirtualPath = "/Citrix/Roaming"

# -------------------------------------------
# End of First Delivery Controller Scaffold
# -------------------------------------------

# -------------------------------------------
# Delivery Controllers Specifications
# -------------------------------------------

#do not modify
[Array]$Farms = @()
[Int]$SiteID = 1

# -------------------------------------------
# Spec 1 - XenDesktop Farm 1
# -------------------------------------------

# do not modify the following 2 lines
# we only support single site storefront currently
[HashTable]$FarmSettings = @{}

#display name
$FarmSettings["FarmName"] = "XenDesktop1"

#do not modify the following 3 lines
[HashTable]$Platform = @{}
$Platform["Caption"] = "PlatformCaption"
$Platform["DisplayName"] = "PlatformDisplayName"

#specify the farm type here
$Platform["FarmType"] = "XenDesktop"

#do not modify the following line
$FarmSettings["Platform"] = $Platform

$FarmSettings["TransportType"] = "HTTPS"
$FarmSettings["Port"] = 443
$FarmSettings["Servers"] = @('cc-cdc01.example.com')
$FarmSettings["SSLRelayPort"] = 443 #$StoreFarm["SSLRelayPort"]
$FarmSettings["ShareFileIntegration"] = $False
$FarmSettings["LoadBalance"] = $False

# do not modify the following line
$Farms += $FarmSettings

# -------------------------------------------
# Spec 2 - Xenapp Farm 1
# -------------------------------------------

# do not modify the following lines
[HashTable]$FarmSettings = @{}

# display name
$FarmSettings["FarmName"] = "XenApp1"

#do not modify the following 3 lines
[HashTable]$Platform = @{}
$Platform["Caption"] = "PlatformCaption"
$Platform["DisplayName"] = "PlatformDisplayName"
$Platform["FarmType"] = "XenApp"
$FarmSettings["Platform"] = $Platform

$FarmSettings["TransportType"] = "HTTP"
$FarmSettings["Port"] = 80
$FarmSettings["Servers"] = @('pc-ctx11.example.com','pc-ctx12.prod.example.com')
$FarmSettings["SSLRelayPort"] = 443 #$StoreFarm["SSLRelayPort"]
$FarmSettings["ShareFileIntegration"] = $False
$FarmSettings["LoadBalance"] = $False

#do not modify the following line
$Farms += $FarmSettings

# -------------------------------------------
# End of Delivery Controllers Specifications
# -------------------------------------------

# -------------------------------------------
# AGEE Settings
# -------------------------------------------

$GatewayName = "AGEE"
$GatewayURL = "https://apps.example.com"
$SubnetIPAddress = ""
$CallBackURL = "https://apps.example.com/CitrixAuthService/AuthService.asmx"
$STAURL = "https://cc-cdc01.example/scripts/ctxsta.dll"

# Shared Gateway Variables
[Array]$AuthenticationProtocols = @("ExplicitForms","CitrixAGBasic","IntegratedWindows")
[String]$LogonType = "Domain"
[String]$Deployment = "Appliance"
[String]$XenMobileSTA = "https://cc-cdc01.example/scripts/ctxsta.dll"
$SessionReliability = $true
$RequestTicketTwoSTA = $false

# Contains all Configured Gateway DTO Objects
[Array]$GatewayCluster = @()

# -------------------------------------------
# End of AGEE section
# -------------------------------------------

# -------------------------------------------
# Beacon Settings
# -------------------------------------------

$InternalBeacon = "https://storefront.example.com"
[Array]$ExternalBeacons = @("http://www.citrix.com","https://apps.example.com")

# -------------------------------------------
# end of Beacon Settings
# -------------------------------------------

# -------------------------------------------
# Remote Access Settings
# -------------------------------------------

$StoreRemoteAccessType = "StoresOnly"

# -------------------------------------------
# End of Remote Access Settings
# -------------------------------------------
