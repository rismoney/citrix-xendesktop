class citrix::director {

  $director_packages = [
    'CitrixDirector',
  ]

  package {$director_packages:
    ensure => present,
  }

  $eight_tab = "\t\t\t\t\t\t\t\t"
  $line = '<asp:TextBox ID="Domain" Text="nyise" readonly="true" runat="server" CssClass="text-box" onfocus="showIndicator(this);"'
  $tabbed_line = "${eight_tab}${line}"

  file_line { 'directordomain':
    ensure  => present,
    match   => '\s*<asp:TextBox ID="Domain"',
    path    => 'C:/inetpub/wwwroot/Director/Logon.aspx',
    line    => $tabbed_line,
    require => Package['CitrixDirector'],
  }

  file {'get-autodiscovery-addr.ps1':
    ensure   => present,
    path     => 'C:/@inf/winbuild/scripts/get-autodiscovery-addr.ps1',
    source   => "puppet:///modules/${module_name}/get-autodiscovery-addr.ps1",
  }

  file {'set-autodiscovery-addr.ps1':
    ensure   => present,
    path     => 'C:/@inf/winbuild/scripts/set-autodiscovery-addr.ps1',
    source   => "puppet:///modules/${module_name}/set-autodiscovery-addr.ps1",
  }

  exec {'set-autodiscovery-addr':
    command      => 'c:/@inf/winbuild/scripts/set-autodiscovery-addr.ps1',
    provider     => powershell,
    require      => File['get-autodiscovery-addr.ps1','set-autodiscovery-addr.ps1'],
    unless       => 'c:/@inf/winbuild/scripts/get-autodiscovery-addr.ps1',
  }


  realize File ['Disable-NicPowerMgmt.ps1']
  realize Exec ['Disable-NicPowerMgmt']
}
