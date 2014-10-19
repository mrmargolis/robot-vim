require 'spec_helper'

describe RobotVim::InputFile do
  describe "path_for" do
    context "given a file path that exists" do
      it "yields the file path" do
        File.stub(:exists?).and_return(true)
        expected_path = "/some/path/file.txt"
        RobotVim::InputFile.path_for(expected_path) do |path|
          path.should == expected_path
        end
      end
    end

    context "given contents for a file" do
      let(:file_contents) do
        <<-CONTENTS
          Hi there.
          This will serve as our input file.
        CONTENTS
      end

      it "creates a new file with those contents" do
        RobotVim::InputFile.path_for(file_contents) do |path|
          File.read(path).should == file_contents
        end
      end

      it "cleans up the file when we are done with it" do
        file_name = "some_file_name"
        RobotVim::FileNameGenerator.stub(:generate).and_return(file_name)
        RobotVim::InputFile.path_for(file_contents) do |path|
          File.exists?(file_name).should be_true
        end
        File.exists?(file_name).should be_false
      end
    end
  end
end
