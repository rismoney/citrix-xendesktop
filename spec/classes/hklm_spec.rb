require 'spec_helper'

uselessdir = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace'
uselessnav = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace'
runkey = 'HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run'

regvals = [
'DontVerifyRandomDrivers',
'NtfsDisableLastAccessUpdate',
'AppInit_DLLs',
'PerMachine',
'RemoveWindowsStore',
'EnableLogonScriptDelay',
'SyncForegroundPolicy',
'NoNewAppAlert',
'DisableStatus',
'LogoffCheckSysModules',
'DisableNetworkPrintingDisconnect',
'EnableDesktopWindowMonitoring',
]

regkeys = [
'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters\DisableTaskOffload',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoThumbnailCache',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisableThumbnailCache',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\NoThumbnailCache',
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\DisableThumbnailCache',
"#{uselessdir}\\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}",
"#{uselessdir}\\{374DE290-123F-4565-9164-39C4925E467B}",
"#{uselessdir}\\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}",
"#{uselessdir}\\{A0953C92-50DC-43bf-BE83-3742FED03C9C}",
"#{uselessdir}\\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",
"#{uselessnav}\\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}",
"#{uselessnav}\\{374DE290-123F-4565-9164-39C4925E467B}",
"#{uselessnav}\\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}",
"#{uselessnav}\\{A0953C92-50DC-43bf-BE83-3742FED03C9C}",
"#{uselessnav}\\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",
"#{runkey}\\Acrobat Assistant 8.0",
"#{runkey}\\Adobe Acrobat Speed Launcher",
"#{runkey}\\Adobe ARM",
"#{runkey}\\SunJavaUpdateSched",
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

describe 'citrix::xa::hklm' do
  regkeys.each do |regkey|
     context 'on a citrix xa server' do
      let(:facts) do {
        :kernel            => 'windows',
        :operatingsystem   => 'windows',
        :ise_mock_fqdn     => 'cc-cxa00.example.com',
        :ise_mock_function => 'cxa',
      }
      end
      it { should contain_registry_value(regkey) }
    end
  end

  regvals.each do |regval|
    context 'on a citrix xa server' do
      let(:facts) do {
        :kernel            => 'windows',
        :operatingsystem   => 'windows',
        :ise_mock_fqdn     => 'cc-cxa00.example.com',
        :ise_mock_function => 'cxa',
      }
      end
      it { should contain_registry__value(regval) }
    end
  end
end
