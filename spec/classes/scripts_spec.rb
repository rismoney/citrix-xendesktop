require 'spec_helper'

files = [
  'Add-ISEPrinterDrivers.ps1',
  'StartUpXA.ps1',
  'ShutDownXA.ps1',
  'Get-DEP.ps1',
  'Disable-NicPowerMgmt.ps1',
  'disable-tasks.ps1',
  'disabledtasks.csv',
]

execs = [
  'disable-dep',
  'Disable-NicPowerMgmt',
  'disable-tasks',
]

describe 'citrix::xa::scripts' do
  files.each do |file|
    context 'on a citrix xa server the file #{file} should exist' do
      let(:facts) do {
        :kernel            => 'windows',
        :operatingsystem   => 'windows',
        :ise_mock_fqdn     => 'cc-cxa00.example.com',
        :ise_mock_function => 'cxa',
      }
      end
     it { should contain_file(file) }
    end
  end

  execs.each do |exec|
    context 'on a citrix xa server the exec #{exec} should exist' do
      let(:facts) do {
        :kernel            => 'windows',
        :operatingsystem   => 'windows',
        :ise_mock_fqdn     => 'cc-cxa00.example.com',
        :ise_mock_function => 'cxa',
      }
      end
     it { should contain_exec(exec) }
    end
  end
end
