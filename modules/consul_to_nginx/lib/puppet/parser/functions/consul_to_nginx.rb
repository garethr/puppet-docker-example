module Puppet::Parser::Functions
  newfunction(:consul_to_nginx, :type => :rvalue, :doc => <<-EOS
Parse consul services output and generate nginx upstream members
    EOS
  ) do |args|

    data  = args[0]

    if data.is_a?(Hash)
      return Array("#{data['Address']}:#{data['ServicePort']}")
    elsif data.is_a?(Array)
      members = []
      data.each { |service|
        members << "#{service['Address']}:#{service['ServicePort']}"
      }
      return members
    end

  end
end
