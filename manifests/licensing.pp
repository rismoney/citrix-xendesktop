class citrix::licensing {

  package {'CitrixLicensing':
    ensure => present,
  }

  file {'C:/@inf/winbuild/citrix':
    ensure => directory,
  }

  file {'licensefile.lic':
    ensure  => present,
    path    => 'C:/@inf/winbuild/citrix/licensefile.lic',
    source  => "puppet:///modules/${module_name}/licensefile.lic",
    require => File['C:/@inf/winbuild/citrix'],
  }
}
