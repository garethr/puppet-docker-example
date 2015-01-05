require 'serverspec'

include SpecInfra::Helper::DetectOS

if ENV['SERVERSPEC_LOCAL']
  include SpecInfra::Helper::Exec
else
  include SpecInfra::Helper::Ssh
  require 'pathname'
  require 'net/ssh'
end
