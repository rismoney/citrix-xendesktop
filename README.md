citrix-xendesktop
=================

completely automated xendestop deployment via source of truth files

Status
-----
StoreFront installation completely managed via powershell

TODO
----

Configuration included for XenApp and XenDesktop

Single Netscaler with addtl config provided

All configuration is done via sfconfig.ps1...replace example.com with your appropriate hostnames...

Right now the scripts are not "idempotent" so they could blow up on multiple runs...

Order of Execution
* initialize-sf.ps1
* set-farm.ps1
* add-auth.ps1
* add-agee.ps1
* set-beacons.ps1
* set-remoteaccess.ps1
* update-gw.ps1

TODO
----
Delivery Controller
Database
Licensing

Future
----
Integrate into Puppet
Chocolatey Packages (complete but not yet opensourced)
