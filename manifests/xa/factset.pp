class citrix::xa::factset {

  $factsetkeys = [
    'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Excel\Addins\FactSet.Office.Addin.1',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\OneNote\Addins\FactSet.Office.Addin.1',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\FactSet.Office.Addin.1',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\PowerPoint\Addins\FactSet.Office.Addin.1',
    'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Word\Addins\FactSet.Office.Addin.1',
  ]

  registry_value {$factsetkeys:
    ensure => absent,
  }
}
