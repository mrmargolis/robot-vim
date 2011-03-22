# RobotVim - Easy Vim Automation
RobotVim is a Ruby gem that allows you to invoke Vim from inside of Ruby
programs.  It was designed to allow Vim developers to TDD/BDD their Vim plugins
and scripts.

## Important
Right now there is no real code to this project.  It's just this README.  Code is coming soon.

## Installation
To install RobotVim run
    gem install robot-vim
or clone this reposity and run
    rake install

## Dependencies
RobotVim is developed with Vim 7.3, Ruby 1.9.2, and bundler.

## Example Usage

### Initialization
Create an instance that will use your user's default Vim and vimrc file
    robot = RobotVim::Runner.new()

Or create an instance with a specific Vim and/or vimrc file
    robot = RobotVim::Runner.new(:vim => "~/bin/vim",
                                 :vimrc => "examples/vimrc_with_weird_bindings")

### Running commands
Commands are passed in as a string with one command per line.

Run commands against inline input
    commands = <<-COMMANDS
      RunSomeCoolCommand
      SomeOtherCoolCommand
    COMMANDS

    input = <<-INPUT
      This is a some sample
      text that I can pass in as input.
      I could also use a file fixture as my input.
      See the examples folder for more examples.
    INPUT

    result = robot.run(:input_text => input, :commands => commands)
    puts result.buffer_text

Run a command against a test input file
    commands = "normal G|iTyping some text at the bottom of the buffer"
    result = robot.run(:input_file => "examples/input1.txt", :commands => commands)
    puts result.buffer_text

## The result object
The result of the RobotVim#run method has the following attributes

-  buffer\_text:  the text of the buffer after the last command (not yet implemented)
-  buffer\_name:  the name of the buffer after the last command (not yet implemented)
-  cursor\_location:  the curson location after the last command(not yet implemented)

## Author
RobotVim is developed by Matt Margolis | mrmargolis | matt@mattmargolis.net
