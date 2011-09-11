module RobotVim
  class CommandGenerator
    def self.generate(user_commands, output_file)
      user_commands + 
      write_output_file_command(output_file) +
      vim_close_commands
    end

    def self.write_output_file_command(output_file)
      ":w #{output_file}\n"
    end

    def self.vim_close_commands
      "\n:%bd!\n:q!\n"
    end
  end
end
