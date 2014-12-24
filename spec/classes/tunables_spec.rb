require 'spec_helper'

describe 'citrix::xa::tunables' do
  context 'on a citrix xa server' do
    let(:facts) do {
      :kernel            => 'windows',
      :operatingsystem   => 'windows',
      :ise_mock_fqdn     => 'cc-cxa00.example.com',
      :ise_mock_function => 'cxa',
    }
    end
    it { should include_class('citrix::xa::scripts') }
    it { should include_class('citrix::xa::hklm') }
    it { should include_class('citrix::xa::services') }
    it { should include_class('citrix::xa::defaultprofile') }
    it { should include_class('citrix::xa::adobe') }
    it { should include_class('citrix::xa::factset') }
  end
end
