$scriptdir = "C:\@inf\winbuild\scripts"
$logdir = "C:\@inf\winbuild\logs"
$keyfile = join-path $scriptdir "CTXUserSettings.csv"

ipmo PSLogging

$regupdateLog = join-path $logdir "regupdate-$(Get-Date -Format 'yyyy-MM-dd-HHmmss').log"
$LogFile = add-logfile -path $regupdateLog
$userkeys = import-csv $keyfile

# backup default user profile
robocopy C:\Users\Default "C:\@inf\winbuild\scratch\defaultuser-$(Get-Date -Format 'yyyy-MM-dd-HHmmss')" /a-:h
#
# ***** Configure Default User
# *** Load Default User hive into hku\Injecthere
write-host "loading ntuser.dat hive"
reg load "hku\Injecthere" "$env:USERPROFILE\..\Default User\NTUSER.DAT"
#  *** Disable Desktop Cleanup
write-host "loaded!"

foreach ($userkey in $userkeys) {

  $key = ($userkey.key | out-string).trim()
  $name = ($userkey.name |out-string).trim()
  $value = ($userkey.value | out-string).trim()
  $type = ($userkey.type |out-string).trim()
  "$key $name $value $type"
  reg add $key /v $name /t $type /d $value /f
}

reg unload "hku\Injecthere"

$logfile |disable-logfile
