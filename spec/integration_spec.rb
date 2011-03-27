require 'spec_helper'

describe "Automating Vim with RobotVim" do
  let(:runner){RobotVim::Runner.new}

  context "When using an existing input file" do
    it "can sort a file using vim" do
      input_path = File.join(File.dirname(__FILE__), "fixtures", "unsorted_file.txt")
      unsorted_text = File.read(input_path)

      commands = <<-COMMANDS
      :%!sort
      COMMANDS

      result = runner.run(:commands => commands, :input_file => input_path)
      result.should == unsorted_text.split("\n").sort.join("\n") + "\n"
    end
  end

  context "When using a string for input" do
    it "can uppercase the first line" do
      text_to_uppercase = "this line should be uppercased"

      commands = <<-COMMANDS
        :normal 0|gU$
      COMMANDS

      result = runner.run(:commands => commands, :input_file => text_to_uppercase)
      result.should == text_to_uppercase.upcase + "\n"
    end
  end

end
