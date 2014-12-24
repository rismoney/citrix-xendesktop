$addrs = (get-webconfigurationproperty -PSPath "IIS:\Sites\Default Web Site\Director" -filter "/appSettings/add[@key='Service.AutoDiscoveryAddresses']" -name value).value
if ($addrs -eq "cc-cdc01.example.com cc-cdc02.example") {exit 0} else {exit 1}
