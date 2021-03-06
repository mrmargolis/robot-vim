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
      :s/old/new
      :normal! gg
      :call setline('.', "RobotVim")
      :call MyAwesomePluginFunction
    COMMANDS


    vim_response = robot.run(:input_file => "some/file.txt", :commands => commands)


    input = <<-CONTENT
      This text will be used
      as the contents of my input file
    CONTENT

    vim_response = robot.run(:input_file => input, :commands => commands)
    buffer_text = vim_response.body

### VimResponse

The return value of RobotVim::Runner#run is a RobotVim::VimResponse instance with the following fields

- body: The contents of the last buffer that was active when your commands completed
- line\_number: The line number the cursor was on when your commands completed
- column\_number: The column number the cursor was on when your commands completed

**Please submit pull requests or issues if there are additional values that you want to be able to assert against**

### Making Assertions
Use your preferred Ruby testing library to make assertions about the VimResponse returned by RobotVim::Runner#run

Take a look at spec/integration\_spec.rb for examples of asserting with Rspec

## Author
RobotVim is developed by Matt Margolis | @mrmargolis | matt@mattmargolis.net
