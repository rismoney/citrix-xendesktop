asnp Citrix.*
$apps = Get-BrokerApplication | select Name
$apps

foreach ($app in $apps)
{
$in = Get-BrokerApplication -Name $app.Name
Write-Host "Duplicating apps to new deliverygroup: " $in.Name
$in | add-BrokerApplication -DesktopGroup "Corp XenApp Servers"
}
