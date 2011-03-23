require 'spec_helper'

describe RobotVim::Runner do

  describe "specifying which vim to use" do
    it "uses the vim passed in during initialization if provided" do
      vim = "/usr/local/bin/vim"
      robot = RobotVim::Runner.new(:vim => vim)  
      robot.vim_binary.should == vim
    end

    it "defaults to vim in user's path" do
      vim = "vim"
      robot = RobotVim::Runner.new()  
      robot.vim_binary.should == vim
    end
  end

  describe "specifying which vimrc to use" do
    it "uses the vimrc passed in during initialization if provided" do
      vimrc = "/some/path/vimrc"
      robot = RobotVim::Runner.new(:vimrc => vimrc)  
      robot.vimrc.should == vimrc
    end

    it "defaults to vim in user's path" do
      vimrc = "~/.vimrc"
      robot = RobotVim::Runner.new()  
      robot.vimrc.should == vimrc
    end
  end

  describe "running commands in vim" do
    let(:vim_path){"/usr/local/bin/vim"}
    let(:vimrc_path){"/testing/vimrc"}
    let(:robot){RobotVim::Runner.new(:vim => vim_path, :vimrc => vimrc_path)}

    let(:commands){"some vim commands"}
    let(:input_file){"some/path/to/a/file"}

    def run_robot
      robot.run(:commands => commands, :input_file => input_file)
    end

    it "invokes the correct vim" do
      Kernel.should_receive(:`).with(/#{vim_path}/)
        run_robot
    end

    it "uses the correct vimrc" do
      Kernel.should_receive(:`).with(/-u #{vimrc_path}/)
      run_robot
    end

    it "runs against the requested input file" do
      Kernel.should_receive(:`).with(/#{input_file}$/)
        run_robot
    end

    it "runs vim without swap files so vim doesn't show warnings" do
      Kernel.should_receive(:`).with(/-n/)
      run_robot
    end

    it "invokes vim with a script file" do
      script_file_path = "path/to/script/file"
      RobotVim::ScriptFile.stub(:open).and_yield(script_file_path)
      Kernel.should_receive(:`).with(/-s #{script_file_path}/)
      run_robot
    end

  end

end
