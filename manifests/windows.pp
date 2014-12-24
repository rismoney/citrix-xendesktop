class citrix::windows {

  hiera_include('CitrixController',[''])
  hiera_include('CitrixStoreFront',[''])
  hiera_include('CitrixStudio',[''])
  hiera_include('CitrixCerts',[''])
  hiera_include('CitrixLicensing',[''])
  hiera_include('CitrixProvisioning',[''])
  hiera_include('CitrixDirector',[''])
  hiera_include('CitrixXAServers',[''])

  $key_base = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters'

  @registry_value {"${key_base}\\DisableTaskOffload":
    ensure => present,
    type   => 'dword',
    data   => 1
  }

  @file {'Disable-NicPowerMgmt.ps1':
    ensure   => present,
    path     => 'C:\@inf/winbuild/scripts/Disable-NicPowerMgmt.ps1',
    source   => "puppet:///modules/${module_name}/Disable-NicPowerMgmt.ps1",
  }

  @exec {'Disable-NicPowerMgmt':
    command      => 'c:/@inf/winbuild/scripts/Disable-NicPowerMgmt.ps1',
    provider     => powershell,
    require      => File['Disable-NicPowerMgmt.ps1'],
    creates      => 'c:/@inf/winbuild/logs/Disable-NicPowerMgmt.log',
  }
}
