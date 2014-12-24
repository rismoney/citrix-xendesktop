ipmo PSLogging
$logDir = "C:\@inf\winbuild\logs\"
$disabletasklog = join-path $logdir "disable-task-$(Get-Date -Format 'yyyy-MM-dd-HHmmss').log"
$logFile = Add-LogFile -Path $disabletasklog

$scheduledTasks = import-csv disabledtasks.csv
foreach ($scheduledTask in $scheduledTasks) {
    schtasks /change /tn $scheduledtask.taskname /disable
}

$logfile |Disable-LogFile
