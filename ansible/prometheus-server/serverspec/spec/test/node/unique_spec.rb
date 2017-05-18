require 'spec_helper'

describe "Basic OS Settings" do

  describe command('uname -r') do
    its(:stdout) { should match /4.9.20-11.31.amzn1.x86_64/ }
  end

end

describe "Installed Packages" do

  describe package('httpd24') do
    it { should be_installed }
  end

  describe package('php56') do
    it { should be_installed }
  end

  describe package('postfix') do
    it { should be_installed }
  end

end

describe "Listening Ports" do

  describe port(80) do
    it { should be_listening.with('tcp') }
  end

  describe port(443) do
    it { should be_listening.with('tcp') }
  end

end

describe "Not Install Packages" do

  describe package('mysql55-server') do
    it { should_not be_installed }
  end

end

describe "Not Listen Ports" do

end

describe "Not Run Services" do

  describe service('nginx') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

  describe service('mysqld') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

  describe service('sendmail') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

end

describe "Running Services" do

  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('postfix') do
    it { should be_enabled }
    it { should be_running }
  end

end