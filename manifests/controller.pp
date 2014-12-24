class citrix::controller {

  $controller_packages = [
    'CitrixController',
    'CitrixStudio',
  ]

  package {$controller_packages:
    ensure => present,
  }

  realize File ['Disable-NicPowerMgmt.ps1']
  realize Exec ['Disable-NicPowerMgmt']


  file {'C:\@inf\winbuild\scripts\Remove-Applications.ps1':
    ensure  => file,
    source  => "puppet:///modules/${module_name}/Remove-Applications.ps1",
  }

  file {'C:\@inf\winbuild\scripts\Dupe-Applications.ps1':
    ensure  => file,
    source  => "puppet:///modules/${module_name}/Dupe-Applications.ps1",
  }
}
