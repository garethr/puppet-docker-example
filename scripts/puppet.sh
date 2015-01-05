#!/bin/bash

red='\e[0;31m'
orange='\e[0;33m'
green='\e[0;32m'
end='\e[0m'


# if puppet is already installed do nothing
if which /usr/local/bin/puppet > /dev/null 2>&1; then
  echo -e "${orange}----> Puppet is aready installed${end}"
  exit 0
fi

# Ruby on Ubuntu is broken by design :(
echo -e "----> ${green}Installing ruby${end}"
sudo apt-get update
sudo apt-get install ruby2.0 ruby2.0-dev -y
for i in erb gem irb rake rdoc ri ruby testrb
do
  sudo ln -sf /usr/bin/${i}2.0 /usr/bin/${i}
done

# Install language locale as without can
# interfere with package installation
sudo apt-get install language-pack-en -y

# Install puppet/facter
echo -e "----> ${green}Installing puppet${end}"
sudo gem install puppet facter --no-ri --no-rdoc
