require 'spec_helper'

describe "Installed Packages" do

  describe package('awslogs') do
    it { should be_installed }
  end

end