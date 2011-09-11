require 'spec_helper'

describe RobotVim::CommandGenerator do

  describe ".generate" do
    let(:output_file) { "some/file.extension" } 
    let(:user_commands) { "some user commands" } 


    context "return value" do
      subject { RobotVim::CommandGenerator.generate(user_commands, output_file) }
      it { should include(user_commands) } 
      it { should include("\:w #{output_file}\n") } 
      it { should include("\n:%bd!\n:q!\n") } 
    end

  end

end

