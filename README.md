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
Create an instance that will use your user's default Vim
    robot = RobotVim::Runner.new()

Or create an instance with a specific Vim
    robot = RobotVim::Runner.new(:vim => "/bin/vim")

### Running commands
Commands are passed in as a string with one command per line.

    commands = <<-COMMANDS
      RunSomeCoolCommand
      SomeOtherCoolCommand
    COMMANDS

    buffer_text = robot.run(:input_file => "some/file.txt", :commands => commands)


### Making Assertions
Use your preferred Ruby testing library to make assertions about the buffer text string returned by RobotVim::Runner#run

See spec/integration\_spec.rb for an example of sorting a file and making an assertion.

## TODO
- automatically save buffer to an output file after running the last command(done)
- automatically close Vim after running the last command(done)
- take a string for input and write out a temporary file that Vim will run against
- figure out if there is a way to specify a .vimrc file without disabling the normal Vim initialization process

## Author
RobotVim is developed by Matt Margolis | mrmargolis | matt@mattmargolis.net
