require 'spec_helper'

regkeys = [
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Excel\Addins\FactSet.Office.Addin.1',
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\OneNote\Addins\FactSet.Office.Addin.1',
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\FactSet.Office.Addin.1',
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\PowerPoint\Addins\FactSet.Office.Addin.1',
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Word\Addins\FactSet.Office.Addin.1',
]

  describe 'citrix::xa::factset' do
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
end
