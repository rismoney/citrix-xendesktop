#dotsource storefront configuration and header files
. .\sfheader.ps1
. .\sfconfig.ps1

$logfile = join-path $logpath "setfarm.log"
start-transcript -path $logfile -noclobber

$FarmSet = @{
            "Name" = "Default";
            "Farms" = $Farms
            }


Update-DSFarmSet -IISSiteId $SiteID -VirtualPath $StoreVirtualPath -Farmset $FarmSet

stop-transcript