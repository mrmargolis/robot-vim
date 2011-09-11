require 'spec_helper'

describe RobotVim::CommandGenerator do

  describe ".generate" do
    let(:output_file) { "some/file.extension" } 
    let(:user_commands) { "some user commands" } 


    context "return value" do
      let(:write_to_output_file_command) { RobotVim::CommandGenerator.write_output_file_command(output_file) }
      let(:close_vim_commands) { RobotVim::CommandGenerator.vim_close_commands}
      let(:record_location_command) { RobotVim::CommandGenerator.record_location_command } 

      subject { RobotVim::CommandGenerator.generate(user_commands, output_file) }

      it { should include(user_commands) } 
      it { should include(write_to_output_file_command) } 
      it { should include(record_location_command) } 
      it { should include(close_vim_commands) } 
    end

  end

end

