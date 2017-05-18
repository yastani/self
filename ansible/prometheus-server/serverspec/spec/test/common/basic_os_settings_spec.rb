require 'spec_helper'

describe "Basic OS Settings" do

  describe selinux do
    it { should be_disabled }
  end

  describe file('/etc/sysconfig/i18n') do
    its(:content) { should match /LANG=en_US\.UTF-8/ }
  end

  describe command('date') do
    its(:stdout) { should match /JST/ }
  end

  describe command('strings /etc/localtime') do
    its(:stdout) { should match /TZif2\nTZif2\nJST-9/ }
  end

  describe command('cat /etc/system-release') do
    its(:stdout) { should match /Amazon Linux AMI release 2017.03/ }
  end

end