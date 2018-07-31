#!/bin/bash

sudo yum -y install ruby-devel gcc-c++
cd /tmp/serverspec

gem install bundle --no-ri --no-rdoc
gem install io-console --no-ri --no-rdoc

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

bundle install --path vendor/bundle
bundle exec serverspec-runner

gem uninstall io-console
gem uninstall bundle

cd /tmp
rm -fr /tmp/serverspec
sudo yum -y remove ruby-devel gcc-c++