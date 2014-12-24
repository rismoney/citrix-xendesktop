require 'spec_helper'

describe 'citrix::xa::defaultprofile' do
  context 'on a citrix xa server' do
    let(:facts) do {
      :kernel            => 'windows',
      :operatingsystem   => 'windows',
      :ise_mock_fqdn     => 'cc-cxa00.example.com',
      :ise_mock_function => 'cxa',
      }
    end
    it { should contain_file('Update-CTXUserSettings.ps1') }
    it { should contain_file('CTXUserSettings.csv') }
    it { should contain_exec('update-ctxusersettings') }
  end
end
