require 'spec_helper'

describe "Not Listen Ports" do

  describe port(20) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(21) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(20) do
    it { should_not be_listening.with('udp') }
  end

  describe port(21) do
    it { should_not be_listening.with('udp') }
  end

  describe port(23) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(110) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(143) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(465) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(587) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(993) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(995) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(3306) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(5432) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(6379) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(8080) do
    it { should_not be_listening.with('tcp') }
  end

  describe port(11211) do
    it { should_not be_listening.with('tcp') }
  end

end