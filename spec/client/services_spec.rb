require 'spec_helper'

['dnsmasq', 'docker', 'consul', 'nginx'].each do |service_name|
  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end
