class citrix::xa::adobe {

# disable adobe acrobat from check for updates
  registry::value { 'iCheck':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Adobe\Adobe ARM\1.0\ARM',
    data  => 0,
    type  => 'dword',
  }
  # disable improvement dialog at acrobat standard startup
  registry::value { 'bUsageMeasurement':
    key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Adobe Acrobat\9.0\FeatureLockdown',
    data  => 0,
    type  => 'dword',
  }
}
