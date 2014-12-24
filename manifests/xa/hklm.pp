class citrix::xa::hklm {

  require citrix::windows

  realize Registry_value['HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters\DisableTaskOffload']

  registry::value {'EnableDesktopWindowMonitoring':
    key  => 'HKEY_LOCAL_MACHINE\SOFTWARE\Citrix\Ica\Seamless',
    data => 0,
    type => 'dword',
  }

  registry::value {'DisableNetworkPrintingDisconnect':
    key  => 'HKEY_LOCAL_MACHINE\SOFTWARE\Citrix\PrintingSettings',
    data => 1,
    type => 'dword',
  }

  #  disables the logon look-and-feel dialog
  registry::value { 'DisableStatus':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Citrix\Logon',
    data  => 1,
    type  => 'dword',
  }

  registry::value {'LogoffCheckSysModules':
    key  => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Citrix\wfshell\TWI',
    data => 'AppVShNotify.exe,AppVStreamingUX.exe,acrotray.exe,acrodist.exe,Acrobat.exe,FDSSafe.exe',
    type => 'string',
  }

  registry::value { 'NoNewAppAlert':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer',
    data  => 1,
    type  => 'dword',
  }

  registry::value {'SyncForegroundPolicy':
    key  => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Winlogon',
    data => 0,
    type => 'dword',
  }

  registry::value {'EnableLogonScriptDelay':
    key  => 'HKEY_LOCAL_MACHINE\SYSTEM\SOFTWARE\Policies\Microsoft\Windows\System',
    data => 0,
    type => 'dword',
  }

  registry::value { 'RemoveWindowsStore':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore\RemoveWindowsStore',
    data  => 1,
    type  => 'dword',
  }

  $thumbnailkeys = [
    'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoThumbnailCache',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisableThumbnailCache',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\NoThumbnailCache',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\DisableThumbnailCache',
  ]

  registry_value {$thumbnailkeys:
    ensure => present,
    type   => 'dword',
    data   => 1,
  }

  # Store AD schema objects in a single systemcache at %systemroot%\SchCache vs user locations
  registry::value { 'PerMachine':
    key   => 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\adsi\Cache',
    data  => 1,
    type  => 'dword',
  }

  # fixes blank screens during logon
  # http://support.citrix.com/article/CTX139375
  registry::value { 'AppInit_DLLs':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows',
    data  => 'mfaphook64.dll',
    type  => 'string',
  }

  $fskey = 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\FileSystem'
  $fsvalues = ['DontVerifyRandomDrivers',
              'NtfsDisableLastAccessUpdate',
              ]

  registry::value { $fsvalues:
    key   => $fskey,
    data  => 1,
    type  => 'dword',
  }


  # we do not want anything is startup
  $runkey = 'HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run'
  $runkeys = [
    "${runkey}\\Acrobat Assistant 8.0",
    "${runkey}\\Adobe Acrobat Speed Launcher",
    "${runkey}\\Adobe ARM",
    "${runkey}\\SunJavaUpdateSched",
  ]

  $uselessdir = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace'
  $uselessdirs = [
    "${uselessdir}\\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}",
    "${uselessdir}\\{374DE290-123F-4565-9164-39C4925E467B}",
    "${uselessdir}\\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}",
    "${uselessdir}\\{A0953C92-50DC-43bf-BE83-3742FED03C9C}",
    "${uselessdir}\\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",
  ]

  $uselessnav = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace'
  $uselessnavs = [
    "${uselessnav}\\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}",
    "${uselessnav}\\{374DE290-123F-4565-9164-39C4925E467B}",
    "${uselessnav}\\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}",
    "${uselessnav}\\{A0953C92-50DC-43bf-BE83-3742FED03C9C}",
    "${uselessnav}\\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",
  ]

  # active setup keys actions will be removed from HKLM and inserted into default users profile
  $activesetupkeys = [
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{2C7339CF-2B09-4501-B3F3-F3508C9228ED}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{6BF52A52-394A-11d3-B153-00C04F79FAA6}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{89820200-ECBD-11cf-8B85-00AA005B4340}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{89820200-ECBD-11cf-8B85-00AA005B4383}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{89B4C1CD-B018-4511-B0A1-5476DBF70820}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\>{22d6f312-b0f6-11d0-94ab-0080c74c7e95}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Active Setup\Installed Components\{6BF52A52-394A-11d3-B153-00C04F79FAA6}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Active Setup\Installed Components\{89B4C1CD-B018-4511-B0A1-5476DBF70820}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Active Setup\Installed Components\{8A69D345-D564-463c-AFF1-A69D9E530F96}\StubPath',
'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Active Setup\Installed Components\>{22d6f312-b0f6-11d0-94ab-0080c74c7e95}\StubPath',
]

  # workaround until we update stdlib
  $absentkeys1 = concat($uselessdirs,$uselessnavs)
  $absentkeys2 = concat($activesetupkeys,$runkeys)
  $absentkeys = concat($absentkeys1,$absentkeys2)

  registry_value {$absentkeys:
    ensure => absent,
  }

}
