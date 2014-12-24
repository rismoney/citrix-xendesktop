class citrix::certs {

  file {'C:/@inf/winbuild/certs':
    ensure => directory,
  }

  file {'g5.cer':
    ensure  => present,
    path    => 'C:/@inf/winbuild/certs/g5.cer',
    source  => "puppet:///modules/${module_name}/g5.cer",
  }

  exec {'installg5-cert':
    command     => 'CERTUTIL -addstore -f -enterprise root C:\@inf\winbuild\certs\g5.cer',
    provider    => powershell,
    subscribe   => File['g5.cer'],
    refreshonly => true,
  }

  file {'digicert-root.cer':
    ensure  => present,
    path    => 'C:/@inf/winbuild/certs/digicert-root.cer',
    source  => "puppet:///modules/${module_name}/digicert-root.cer",
  }

  exec {'install-digitcert-root':
    command     => 'CERTUTIL -addstore -f -enterprise root C:\@inf\winbuild\certs\digicert-root.cer',
    provider    => powershell,
    subscribe   => File['digicert-root.cer'],
    refreshonly => true,
  }

  file {'digicert-sub.cer':
    ensure  => present,
    path    => 'C:/@inf/winbuild/certs/digicert-sub.cer',
    source  => "puppet:///modules/${module_name}/digicert-sub.cer",
  }

  exec {'install-digitcert-sub':
    command     => 'CERTUTIL -addstore -f -enterprise CA C:\@inf\winbuild\certs\digicert-sub.cer',
    provider    => powershell,
    subscribe   => File['digicert-sub.cer'],
    refreshonly => true,
  }

  file {'ISERootCA.cer':
    ensure => present,
    path   => 'C:/@inf/winbuild/certs/ISERootCA.cer',
    source => "puppet:///modules/${module_name}/ISERootCA.cer",
  }

  exec {'install-ISERootCA':
    command     => 'CERTUTIL -addstore -f -enterprise root C:\@inf\winbuild\certs\ISERootCA.cer',
    provider    => powershell,
    subscribe   => File['ISERootCA.cer'],
    refreshonly => true,
  }

  file {'ISESUBCA1.cer':
    ensure => present,
    path   => 'C:/@inf/winbuild/certs/ISESUBCA1.cer',
    source => "puppet:///modules/${module_name}/ISESUBCA1.cer",
  }

  exec {'install-ISESUBCA1.cer':
    command     => 'CERTUTIL -addstore -f -enterprise CA C:\@inf\winbuild\certs\ISESUBCA1.cer',
    provider    => powershell,
    subscribe   => File['ISESUBCA1.cer'],
    refreshonly => true,
  }
}
