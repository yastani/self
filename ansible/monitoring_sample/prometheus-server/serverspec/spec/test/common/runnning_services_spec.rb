require 'spec_helper'

describe "Running Services" do

  describe service('awslogs') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('ntpd') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('rsyslogd') do
    it { should be_running }
  end

  describe service('sshd') do
    it { should be_enabled }
    it { should be_running }
  end

end