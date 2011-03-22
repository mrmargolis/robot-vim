require 'spec_helper'

describe RobotVim::Runner do

  describe "choosing which vim to use" do
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

  describe "indicating which vimrc to use" do
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

    context "Running commands against an existing file" do
      let(:commands){"some vim commands"}
      let(:input_file){"some/path/to/a/file"}

      def run_robot
        robot.run(:commands => commands, :input_file => input_file)
      end

      it "invokes the correct vim" do
        Kernel.should_receive(:`).with(/#{vim_path}/)
        run_robot
      end

      it "invokes the correct vimrc" do
        Kernel.should_receive(:`).with(/-u #{vimrc_path}/)
        run_robot
      end

      it "runs against the requested input file" do
        Kernel.should_receive(:`).with(/#{input_file}$/)
        run_robot
      end

      it "invokes vim with a script file" do
        pending "Implement script file generation"
        Kernel.should_receive(:`).with(/-s some script file/)
        run_robot
      end

    end

    context "Running commands against an inline input string" do

    end

  end

end
