require 'spec_helper'

describe RobotVim::ScriptFile do
  describe "when creating a script file from a string" do
    let(:commands_string){"some string of vim commands"}

    it "yields the path of the script file" do
      expected_path = "/some/path/somewhere"
      tempfile = stub("tempfile", :path => expected_path).as_null_object
      Tempfile.stub(:open).and_yield(tempfile)

      RobotVim::ScriptFile.open(commands_string) do |file_path|
        file_path.should == expected_path
      end
    end

    it "writes the commands out to the script file" do
      RobotVim::ScriptFile.open(commands_string) do |file_path|
        File.read(file_path).should == commands_string
      end
    end

  end
end
