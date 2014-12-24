class citrix::xa::scripts {

  require citrix::windows

  file {'C:/@inf/winbuild/jobs':
    ensure   => directory
  }

  file {'Add-ISEPrinterDrivers.ps1':
    ensure  => present,
    path    => 'C:/@inf/winbuild/Add-ISEPrinterDrivers.ps1',
    source  => "puppet:///modules/${module_name}/Add-ISEPrinterDrivers.ps1",
  }

  file {'StartUpXA.ps1':
    ensure  => present,
    path    => 'C:/@inf/winbuild/jobs/StartUpXA.ps1',
    source  => "puppet:///modules/${module_name}/jobs/StartUpXA.ps1",
    require => File['C:/@inf/winbuild/jobs'],
  }

  file {'ShutDownXA.ps1':
    ensure   => present,
    path     => 'C:/@inf/winbuild/jobs/ShutDownXA.ps1',
    source   => "puppet:///modules/${module_name}/jobs/ShutDownXA.ps1",
    require  => File['C:/@inf/winbuild/jobs'],
  }

  file {'Get-DEP.ps1':
    ensure   => present,
    path     => 'C:/@inf/winbuild/scripts/Get-DEP.ps1',
    source   => "puppet:///modules/${module_name}/Get-DEP.ps1",
  }

  exec {'disable-dep':
    command      => 'c:/windows/system32/bcdedit.exe /set `{current`} nx AlwaysOff',
    provider     => powershell,
    require      => File['Get-DEP.ps1'],
    unless       => 'c:/@inf/winbuild/scripts/Get-DEP.ps1',
  }

  realize File ['Disable-NicPowerMgmt.ps1']
  realize Exec ['Disable-NicPowerMgmt']

  file {'disable-tasks.ps1':
    ensure  => present,
    path    => 'C:/@inf/winbuild/scripts/disable-tasks.ps1',
    source  => "puppet:///modules/${module_name}/disable-tasks.ps1",
  }

  file {'disabledtasks.csv':
    ensure  => present,
    path    => 'C:/@inf/winbuild/scripts/disabledtasks.csv',
    source  => "puppet:///modules/${module_name}/disabledtasks.csv",
  }

  exec {'disable-tasks':
    command     => 'c:/@inf\winbuild/scripts/disable-tasks.ps1',
    provider    => powershell,
    require     => File['disable-tasks.ps1'],
    subscribe   => File['disabledtasks.csv'],
    refreshonly => true,
  }
}
