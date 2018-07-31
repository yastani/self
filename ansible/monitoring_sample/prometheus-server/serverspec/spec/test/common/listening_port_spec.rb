require 'spec_helper'

describe "Listening Ports" do

  describe port(22) do
    it { should be_listening.with('tcp') }
  end

  describe port(25) do
    it { should be_listening.on('127.0.0.1').with('tcp') }
  end

end