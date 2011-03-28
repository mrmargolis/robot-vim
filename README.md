# RobotVim - Easy Vim Automation
RobotVim is a Ruby gem that allows you to invoke Vim from inside of Ruby
programs.  It was designed to allow Vim developers to TDD/BDD their Vim plugins
and scripts.

## Installation
To install RobotVim run
    gem install robot-vim
or clone this reposity and run
    rake install


## Dependencies
RobotVim is developed with Vim 7.3, Ruby 1.9.2, and bundler.


## Example Usage

### Initialization
Create an instance that will use your user's default Vim and vimrc
    robot = RobotVim::Runner.new()

Create an instance with a specific Vim
    robot = RobotVim::Runner.new(:vim => "/bin/vim")

Create an instance with a specific vimrc
    robot = RobotVim::Runner.new(:vimrc => "something/vimrc")

### Running commands
Commands are passed in as a string with one command per line.

The input file can be specified as a path to an existing input file, or as a string which RobotVim will turn into an short lived file backed buffer.

    commands = <<-COMMANDS
      RunSomeCoolCommand
      SomeOtherCoolCommand
    COMMANDS


    buffer_text = robot.run(:input_file => "some/file.txt", :commands => commands)

    input = <<-CONTENT
      This text will be used
      as the contents of my input file
    CONTENT

    buffer_text = robot.run(:input_file => input, :commands => commands)


### Making Assertions
Use your preferred Ruby testing library to make assertions about the buffer text string returned by RobotVim::Runner#run

spec/integration\_spec.rb contains examples of asserting with Rspec

## TODO
- automatically save buffer to an output file after running the last command(done)
- automatically close Vim after running the last command(done)
- take a string for input and write out a temporary file that Vim will run against(done)
- figure out if there is a way to specify a .vimrc file without disabling the normal Vim initialization process(done)

## Author
RobotVim is developed by Matt Margolis | mrmargolis | matt@mattmargolis.net
