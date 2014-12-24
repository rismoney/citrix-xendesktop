asnp Citrix.*
$apps = Get-BrokerApplication | select Name
$apps

foreach ($app in $apps)
{
  $in = Get-BrokerApplication -Name $app.Name
  Write-Host "Removing apps from deliverygroup: " $in.Name
  $in | Remove-BrokerApplication -DesktopGroup "Corp Test Servers"
}
