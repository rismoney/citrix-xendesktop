# Use the Personality.ini to determine if we are in Private (READ/WRITE)
# vs Standard Mode (READ ONLY)

$personalitySearch = select-string C:\Personality.ini -Pattern "_DiskMode"
$diskmode = $personalitySearch.line.split("=")[1]

if ($diskmode -eq "P") {

  write-host "We are in Private mode"

  # In Private Mode we need to perform the following activities
  # 1. stop Mcafee Services
  # 2. Remove Node Specific Data from ePO agent

  $services = @()
  $services += "McafeeFramework"
  $services += "Mcshield"
  $services += "McTaskManager"

  foreach ($service in $services) {
    stop-service $service
  }

  $Regkeys = @()
  $Regkeys += "HKLM:\Software\Wow6432node\Network Associates\ePolicy Orchestrator\Agent"
  $Regkeys += "HKLM:\Software\Network Associates\ePolicy Orchestrator\Agent"

  $Regkeys | %{
    $key = Get-ItemProperty -LiteralPath $_

    $RegItems = @('AgentGUID',
                'ComputerName',
                'IPAddress',
                'MacAddress',
                'SubnetAddress',
                'SubnetMask'
               )

    foreach ($RegItem in $RegItems) {
      $key | Remove-ItemProperty -Name $RegItem -Force -ErrorAction SilentlyContinue
    }
  }
}
else {
  # In Standard mode we need to perform the following activities:
  # 1. Copy DAT files to D: drive to persist the latest versions
  # 2. Persist the node specific ePO settings to D:\ for consumption at startup

  write-host "We are in standard mode"
  $computername = hostname
  $targetDATDirectory = "D:\$computername\Mcafee"
  $DATDirExists = test-path $targetDATDirectory
  if ($DatDirExists -eq $false) {mkdir $targetDATDirectory}

  #copy the DAT files for local storage
  copy "${env:ProgramFiles(x86)}\Common Files\McAfee\Engine\*.DAT" $targetDATDirectory

  $Regkeys = @()
  $Regkeys += "HKLM:\Software\Wow6432node\Network Associates\ePolicy Orchestrator\Agent"
  #$Regkeys += "HKLM:\Software\Network Associates\ePolicy Orchestrator\Agent"

  $entries = "Key,Item,Value,Type`r`n"

  $Regkeys | %{
    $key = Get-ItemProperty -LiteralPath $_

    $RegItems = @('AgentGUID',
                  'ComputerName',
                  'IPAddress',
                  'MacAddress',
                  'SubnetAddress',
                  'SubnetMask'
                 )

    foreach ($RegItem in $RegItems) {
      $reg_value = $key | Get-ItemProperty -Name $RegItem
      $entries += "$Regkeys,$RegItem,"+ $reg_value.$regItem + ",REG_SZ" + "`r`n"

    }
  }
  $entries | out-file -FilePath "D:\$computername\mcafee.txt" -force -Encoding string
}
