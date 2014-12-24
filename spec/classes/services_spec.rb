require 'spec_helper'

services = [
  'ALG',
  'Browser',
  'DeviceAssociationService',
  'DPS',
  'TrkWks',
  'FDResPub',
  'defragsvc',
  'SstpSvc',
  'ShellHWDetection',
  'SNMPTRAP',
  'SSDPSrv',
  'tapisrv',
  'upnphost',
  'WcsPlugInService',
  'WerSvc',
  'wuauserv',
]

describe 'citrix::xa::services' do
  services.each do |service|
    context 'on a citrix xa server' do
      let(:facts) do {
        :kernel            => 'windows',
        :operatingsystem   => 'windows',
        :ise_mock_fqdn     => 'cc-cxa00.example.com',
        :ise_mock_function => 'cxa',
      }
      end
     it { should contain_service(service) }
    end
  end
end
