$namespace = "root\WMI"
$computer = hostname
$logpath = 'C:\@inf\winbuild\logs'

$logfile = join-path $logpath "Disable-NicPowerMgmt.log"
start-transcript -path $logfile -noclobber

# this script is based on http://powershell.com/cs/forums/p/2286/3105.aspx

Write-Host "Disable `"Allow the computer to turn off this device to save power`""
Get-WmiObject -computername $computer Win32_NetworkAdapter -filter "AdapterTypeId=0" | % {
  $strNetworkAdapterID=$_.PNPDeviceID.ToUpper()
  Get-WmiObject -class MSPower_DeviceEnable -computername $computer -Namespace $namespace | % {
    if($_.InstanceName.ToUpper().startsWith($strNetworkAdapterID)){
    $_.Enable = $false
    $_.Put() | Out-Null
    }
  }
}


Write-Host "Disable `"Allow this device to wake the computer`""
Get-WmiObject -computername $computer Win32_NetworkAdapter -filter "AdapterTypeId=0" | % {
  $strNetworkAdapterID=$_.PNPDeviceID.ToUpper()
  Get-WmiObject -class MSPower_DeviceWakeEnable -computername $computer -Namespace $namespace | % {
    if($_.InstanceName.ToUpper().startsWith($strNetworkAdapterID)){
    $_.Enable = $false
    $_.Put() | Out-Null
    }
  }
}

Write-Host "Disable `"Only allow a magic packet to wake the computer`""
Get-WmiObject -computername $computer Win32_NetworkAdapter -filter "AdapterTypeId=0" | % {
  $strNetworkAdapterID=$_.PNPDeviceID.ToUpper()
  Get-WmiObject -class MSNdis_DeviceWakeOnMagicPacketOnly -computername $computer -Namespace $namespace | % {
    if($_.InstanceName.ToUpper().startsWith($strNetworkAdapterID)){
    $_.EnableWakeOnMagicPacketOnly = $false
    $_.Put() | Out-Null
    }
  }
}

