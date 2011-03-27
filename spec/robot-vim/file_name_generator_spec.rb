require 'spec_helper'

describe RobotVim::FileNameGenerator do
  describe "generating a file name" do
    it "returns a unique name each time" do
      names = (1..5).map{|x| RobotVim::FileNameGenerator.generate}
      names.uniq.size.should eql(names.size)
    end
  end
end
