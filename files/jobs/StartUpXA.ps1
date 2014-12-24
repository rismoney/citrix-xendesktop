$computername = hostname
$sourceDATDirectory = "D:\$computername\Mcafee"

# copy the cached DAT directory so it is using the version based on the last time
#the image was updated via ePO (from the previous shutdown)

copy $sourceDATDirectory\*.DAT "${env:ProgramFiles(x86)}\Common Files\McAfee\Engine"

# import the computer specific values from the cached registry mcafee that we got
#from a previous shutdown
$csv = Import-Csv D:\$computername\mcafee.txt

foreach ($line in $csv) {
  if ($line.type -eq "REG_SZ") {$reg_type = "String"}
  New-ItemProperty $line.key -Name $line.item -Value $line.value -PropertyType $reg_type -ea silentlycontinue
}

# the first time a system starts eventlog service the D:\Logs will not exist.
# so we must reboot at least 1x per node since we cannot make the eventlog service
# dependent on D:\Logs being there.

$targetLogDirectory = "D:\Logs"
$LogDirExists = test-path $targetLogDirectory
if ($LogDirExists -eq $false) {mkdir $targetLogDirectory}
