require 'spec_helper'

describe RobotVim::Runner do

  describe "specifying which vim to use" do
    it "uses the vim passed in during initialization if provided" do
      vim = "/usr/local/bin/vim"
      runner = RobotVim::Runner.new(:vim => vim)
      runner.vim_binary.should == vim
    end

    it "defaults to vim in user's path" do
      vim = "vim"
      runner = RobotVim::Runner.new()
      runner.vim_binary.should == vim
    end
  end

  describe "running commands in vim" do
    let(:vim_path){"/usr/local/bin/vim"}
    let(:runner){RobotVim::Runner.new(:vim => vim_path)}
    let(:commands){"some vim commands\n"}
    let(:input_file){"some/path/to/a/file"}

    before do
      Kernel.stub(:`)
      File.stub(:read)
    end

    def run_robot
      runner.run(:commands => commands, :input_file => input_file)
    end

    it "invokes the correct vim" do
      Kernel.should_receive(:`).with(/#{vim_path}/)
      run_robot
    end

    it "runs against the requested input file" do
      Kernel.should_receive(:`).with(/#{input_file}$/)
      run_robot
    end

    it "runs vim without swap files so vim doesn't show swap warnings" do
      Kernel.should_receive(:`).with(/-n/)
      run_robot
    end

    it "invokes vim with a script file" do
      script_file_path = "path/to/script/file"
      RobotVim::ScriptFile.stub(:open).and_yield(script_file_path)
      Kernel.should_receive(:`).with(/-s #{script_file_path}/)
      run_robot
    end

    it "adds a write command to the user supplied commands" do
      RobotVim::ScriptFile.should_receive(:open).with(/\n\:w/)
      run_robot
    end

    it "generates a unique filename for the output file on each run" do
      files = []
      RobotVim::ScriptFile.should_receive(:open) do |msg|
        files <<  msg.match(/:w (.*)/)[1]
      end.twice
      run_robot
      run_robot
      files[0].should_not == files[1]
    end

    it "adds vim closing commands to the user supplied commands" do
      RobotVim::ScriptFile.should_receive(:open).with(/:%bd!\n:q!/)
      run_robot
    end

    describe "output file management" do
      let(:output_file_name){"output_file_name"}

      before do
        RobotVim::FileNameGenerator.stub(:generate).and_return(output_file_name)
      end

      it "returns the contents of the output file" do
        expected_result = "awesome buffer"
        File.stub(:read).with(output_file_name).and_return(expected_result)
        result = run_robot
        result.should == expected_result
      end

      it "deletes the output file" do
        run_robot
        File.exists?(output_file_name).should be_false
      end
    end
  end

end
