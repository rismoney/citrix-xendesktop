class citrix::pvs {

  require citrix::windows
  $pvs_packages = [
    'CitrixProvisioning',
    'CitrixProvisioningConsole',
  ]

  package {$pvs_packages:
    ensure => present,
  }

  realize Registry_value['HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters\DisableTaskOffload']

  realize File ['Disable-NicPowerMgmt.ps1']
  realize Exec ['Disable-NicPowerMgmt']

  registry::value { 'SkipBootMenu':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Citrix\ProvisioningServices\StreamProcess',
    data  => 1,
    type  => 'dword',
  }
}
