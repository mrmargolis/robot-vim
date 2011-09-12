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

  describe "specifying which vimrc to use" do
    it "uses the vimrc passed in during initialization if provided" do
      vimrc = "/testing/vimrc"
      runner = RobotVim::Runner.new(:vimrc => vimrc)
      runner.vimrc.should == vimrc
    end

    it "defaults to vimrc in user's path" do
      runner = RobotVim::Runner.new()
      runner.vimrc.should == RobotVim::Runner::DEFAULT_VIMRC
    end
  end

  describe "running commands in vim" do
    let(:vim_path){"/usr/local/bin/vim"}
    let(:runner){RobotVim::Runner.new(:vim => vim_path)}
    let(:commands){"some vim commands\n"}
    let(:input_file){"some/path/to/a/file"}

    before do
      Kernel.stub(:`)
      runner.stub(:read_output_file_contents).and_return("some file contents")
      RobotVim::InputFile.stub(:path_for).and_yield(input_file)
    end

    def run_robot
      runner.run(:commands => commands, :input_file => input_file)
    end

    it "invokes the correct vim" do
      Kernel.should_receive(:`).with(/#{vim_path}/)
      run_robot
    end

    it "runs against the requested input file" do
      Kernel.should_receive(:`).with(/#{input_file}/)
      run_robot
    end

    it "redirects stderr so we don't see Vim warnings about not outputting to a terminal" do
      Kernel.should_receive(:`).with(/2>\/dev\/null/)
      run_robot
    end

    it "runs vim without swap files so vim doesn't show swap warnings" do
      Kernel.should_receive(:`).with(/-n/)
      run_robot
    end

    it "runs vim in No-compatible mode so vim properly loads vimrcs and plugins" do
      Kernel.should_receive(:`).with(/-N/)
      run_robot
    end

    it "invokes vim with a script file" do
      script_file_path = "path/to/script/file"
      RobotVim::ScriptFile.stub(:open).and_yield(script_file_path)
      Kernel.should_receive(:`).with(/-s #{script_file_path}/)
      run_robot
    end

    it "invokes vim with a vimrc" do
      vimrc = "some/vimrc"
      runner.stub(:vimrc).and_return(vimrc)
      Kernel.should_receive(:`).with(/-u #{vimrc}/)
      run_robot
    end

    it "generates commands for the script file based on user input" do
      generated_commands = stub('generated commands')
      RobotVim::CommandGenerator.stub!(:generate).with(commands, anything()).and_return(generated_commands)
      RobotVim::ScriptFile.should_receive(:open).with(generated_commands)
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

    describe "output file management" do
      let(:output_file_name){"output_file_name"}

      before do
        RobotVim::FileNameGenerator.stub(:generate).and_return(output_file_name)
      end

      it "deletes the output file" do
        run_robot
        File.exists?(output_file_name).should be_false
      end
    end

    describe "return value" do
      it "returns a VimResponse that is initialized with the output file contents" do
        response = run_robot
        response.should be_kind_of(RobotVim::VimResponse)
      end
    end
  end

end
