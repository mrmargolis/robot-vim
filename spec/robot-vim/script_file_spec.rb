require 'spec_helper'

describe RobotVim::ScriptFile do
  describe "when creating a script file from a string" do
    let(:commands_string){"some string of vim commands"}

    it "yields the path of the script file" do
      expected_path = "/some/path/somewhere"
      UUID.stub_chain(:new, :generate => expected_path)
      file = stub("file").as_null_object
      File.stub(:new).and_return(file)

      RobotVim::ScriptFile.open(commands_string) do |file_path|
        file_path.should == expected_path
      end
    end

    it "writes the commands out to the script file" do
      RobotVim::ScriptFile.open(commands_string) do |file_path|
        File.read(file_path).should == commands_string
      end
    end

    it "deletes the file after we are done using it" do
      file_name = "somefile" 
      UUID.stub_chain(:new, :generate => file_name)
      RobotVim::ScriptFile.open(commands_string) do |file_path|
      end
      File.exists?(file_name).should be_false
    end

  end
end
