# this script will first create a connection to the printers below
# and autoinstall drivers (add-printer does this automatically)

# then it will remove the print queues leaving behind the drivers
# (remove-printer deletes queues not drivers)

$printerserver = 'officeprint.example.com'

# this should ideally be moved into a printers.txt file.
# this was obtained from a get-printers on the printerserver

$printers = @(
 'PRINTER1',
 'PRINTER2',
 )

foreach ($printer in $printers) {
    write-host "Adding Printer: $printer"
    Add-Printer -ConnectionName "\\$printerserver\$printer"

}
#remove all printers from the office printer server.
remove-printer \\officeprint*
