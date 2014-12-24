class citrix::xa::defaultprofile {

  file {'Update-CTXUserSettings.ps1':
    ensure  => present,
    path    => 'C:/@inf/winbuild/scripts/Update-CTXUserSettings.ps1',
    source  => "puppet:///modules/${module_name}/Update-CTXUserSettings.ps1",
  }

  file {'CTXUserSettings.csv':
    ensure  => present,
    path    => 'C:/@inf/winbuild/scripts/CTXUserSettings.csv',
    source  => "puppet:///modules/${module_name}/CTXUserSettings.csv",
  }

  exec {'update-ctxusersettings':
    command     => 'c:/@inf\winbuild/scripts/Update-CTXUserSettings.ps1',
    provider    => powershell,
    require     => File['Update-CTXUserSettings.ps1'],
    subscribe   => File['CTXUserSettings.csv'],
    refreshonly => true,
  }
}
