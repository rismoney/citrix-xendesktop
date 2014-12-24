require 'spec_helper'

describe 'citrix::windows' do
  context 'on a citrix xa server' do
    let(:facts) do {
      :kernel            => 'windows',
      :operatingsystem   => 'windows',
      :ise_mock_fqdn     => 'cc-cxa00.example.com',
      :ise_mock_function => 'cxa',
    }
    end
    it { should include_class('citrix::xa::tunables') }
  end

  context 'not on a citrix xa server' do
    let(:facts) do {
      :kernel            => 'windows',
      :operatingsystem   => 'windows',
      :ise_mock_fqdn     => 'cc-csf00.example.com',
      :ise_mock_function => 'csf',
    }
    end
    it { should_not include_class('citrix::xa::tunables') }
  end
end
