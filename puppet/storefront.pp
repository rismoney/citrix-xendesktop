class citrix::storefront {

  package {'CitrixStoreFront':
    ensure => present,
  }

  file {'g5.cer':
    ensure  => present,
    path    => 'C:/@inf/g5.cer',
    source  => "puppet:///modules/${module_name}/g5.cer",
    require => Package['CitrixStoreFront'],
  }

  exec {'install-cert':
    command     => 'CERTUTIL -addstore -f -enterprise root C:\@inf\g5.cer',
    provider    => powershell,
    subscribe   => File['g5.cer'],
    refreshonly => true,
  }

  if $::ise_mock_sequence == '01' {

    file {'c:/@inf/citrix':
      ensure  => directory,
      source  => "puppet:///modules/${module_name}/storefront",
      purge   => true,
      recurse => true,
      force   => true,
    }

    exec {'initialize-sf.ps1':
      command    => 'c:/@inf/citrix/initialize-sf.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => File['c:/@inf/citrix'],
      cwd        => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/initialize-sf.log',
    }

    exec {'set-farm.ps1':
      command    => 'c:/@inf/citrix/set-farm.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => [File['c:/@inf/citrix'],Exec['initialize-sf.ps1']],
      cwd        => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/set-farm.log',
    }

    exec {'add-auth.ps1':
      command    => 'c:/@inf/citrix/add-auth.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => [File['c:/@inf/citrix'],Exec['set-farm.ps1']],
      cwd        => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/add-auth.log',
    }

    exec {'add-agee.ps1':
      command    => 'c:/@inf/citrix/add-agee.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => [File['c:/@inf/citrix'],Exec['add-auth.ps1']],
      cwd        => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/add-agee.log',
    }

    exec {'set-beacons.ps1':
      command     => 'c:/@inf/citrix/set-beacons.ps1',
      provider    => powershell,
      logoutput   => true,
      require     => [File['c:/@inf/citrix'],Exec['add-agee.ps1']],
      cwd         => 'C:/@inf/citrix',
      creates     => 'c:/@inf/winbuild/logs/citrix/set-beacons.log',
    }

    exec {'set-remoteaccess.ps1':
      command    => 'c:/@inf/citrix/set-remoteaccess.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => [File['c:/@inf/citrix'],Exec['set-beacons.ps1']],
      cwd        => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/set-remoteaccess.log',
    }

    exec {'update-gw.ps1':
      command    => 'c:/@inf/citrix/update-gw.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => [File['c:/@inf/citrix'],Exec['set-remoteaccess.ps1']],
      path       => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/update-gw.log',
    }
    exec {'httpredirect.ps1':
      command    => 'c:/@inf/citrix/httpredirect.ps1',
      provider   => powershell,
      logoutput  => true,
      require    => [File['c:/@inf/citrix'],Exec['update-gw.ps1']],
      path       => 'C:/@inf/citrix',
      creates    => 'c:/@inf/winbuild/logs/citrix/httpredirect.log',
    }
  }
}
