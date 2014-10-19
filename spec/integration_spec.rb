require 'spec_helper'

describe "Automating Vim with RobotVim" do
  describe "Input files" do
    let(:runner){RobotVim::Runner.new}
    context "When using an existing input file" do
      it "can sort a file using vim" do
        input_path = File.join(File.dirname(__FILE__), "fixtures", "unsorted_file.txt")
        unsorted_text = File.read(input_path)

        commands = <<-COMMANDS
      :%!sort
        COMMANDS

        result = runner.run(:commands => commands, :input_file => input_path)
        result.body.should == unsorted_text.split("\n").sort.join("\n")
      end
    end

    context "When using a string for input" do
      it "can uppercase the first line" do
        text_to_uppercase = "this line should be uppercased"

        commands = <<-COMMANDS
        :normal 0|gU$
        COMMANDS

        result = runner.run(:commands => commands, :input_file => text_to_uppercase)
        result.body.should == text_to_uppercase.upcase
      end
    end
  end

  describe "Specifying a vimrc" do
    it "can run a little function defined in a vimrc" do
      input = "Beer bread is delicious.  Beard bread is not"

      commands = <<-COMMANDS
        :call ConvertNotToGross()
      COMMANDS

      vimrc = File.join(File.dirname(__FILE__), "fixtures", "vimrc_with_not_to_gross")
      runner = RobotVim::Runner.new(:vimrc => vimrc)
      result = runner.run(:commands => commands, :input_file => input)
      result.body.should == input.sub("not", "gross")
    end
  end

  describe "running commands that take user input" do
    it "can run fake user input" do
      input = "I am going to be replaced by the user's input"

      commands = <<-COMMANDS
        :call AskMeSomething()
yes please
      COMMANDS

      vimrc = File.join(File.dirname(__FILE__), "fixtures", "vimrc_with_user_input")
      runner = RobotVim::Runner.new(:vimrc => vimrc)
      result = runner.run(:commands => commands, :input_file => input)
      result.body.should == "yes please"
    end
  end

  describe "verifying location of cursor" do
    it "detects the correct line and column numbers" do
      input = "Here is some text\n" +
              "and more on a different line\n" +
              "behold, the lines just keep going\n" +
              "really?"

      commands = <<-COMMANDS
        :normal! gg
        :normal! jj
        :normal! 0llll
      COMMANDS

      runner = RobotVim::Runner.new()
      result = runner.run(:commands => commands, :input_file => input)
      puts result.body
      result.line_number.should == 3
      result.column_number.should == 5
    end
  end
end
