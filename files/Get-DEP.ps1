$dep=(Get-WmiObject -Class Win32_OperatingSystem).DataExecutionPrevention_SupportPolicy
# values: 0 AlwaysOff 1 AlwaysOn 2 OptIn 3 OptOut
# exit 0 if dep is AlwaysOff
if ($dep -eq 0) {exit 0} else {exit 1}
