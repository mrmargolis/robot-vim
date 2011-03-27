require 'spec_helper'

describe "Automating Vim with RobotVim" do
  it "can sort a file using vim" do
    input_path = File.join(File.dirname(__FILE__), "fixtures", "unsorted_file.txt")
    unsorted_text = File.read(input_path)

    commands = <<-COMMANDS
      :%!sort
    COMMANDS

    runner = RobotVim::Runner.new
    result = runner.run(:commands => commands, :input_file => input_path)
    result.should eql(unsorted_text.split("\n").sort.join("\n") + "\n")
  end
end
