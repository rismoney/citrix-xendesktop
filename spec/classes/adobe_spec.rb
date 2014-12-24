require 'spec_helper'

regvals = [
  'iCheck',
  'bUsageMeasurement',
]

describe 'citrix::xa::adobe' do
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
