set-webconfigurationproperty -PSPath "IIS:\Sites\Default Web Site\Director" -filter "/appSettings/add[@key='Service.AutoDiscoveryAddresses']" -name value -value "cc-cdc01.example.com cc-cdc01.example.com"
