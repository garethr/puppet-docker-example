require 'spec_helper'

describe user('vagrant') do
  it { should exist }
end

describe user('root') do
  it { should exist }
end
