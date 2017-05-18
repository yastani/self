require 'spec_helper'

describe "Not Install Packages" do

  describe package('dovecot') do
    it { should_not be_installed }
  end

end