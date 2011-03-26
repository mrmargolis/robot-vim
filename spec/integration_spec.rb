require 'spec_helper'

describe "Automating Vim with RobotVim" do
  it "can sort a file using vim" do
    input_path = File.join(File.dirname(__FILE__), "fixtures", "unsorted_file.txt")
    unsorted_text = File.read(input_path)

    output_file = "output.txt"

    commands = <<-COMMANDS
      :%!sort
      :w #{output_file}
      :%bd!
      :q!
    COMMANDS

    runner = RobotVim::Runner.new
    runner.run(:commands => commands, :input_file => input_path)
    result = File.read(output_file)
    result.should eql(unsorted_text.split("\n").sort.join("\n") + "\n")
  end
end
