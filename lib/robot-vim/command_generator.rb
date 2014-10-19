module RobotVim
  class CommandGenerator
    def self.generate(user_commands, output_file)
      user_commands +
        record_location_command +
        write_output_file_command(output_file) +
        vim_close_commands
    end

    def self.write_output_file_command(output_file)
      ":w #{output_file}\n"
    end

    def self.record_location_command
      ":let current_line = line(\".\")\n" +
      ":let current_column = col(\".\")\n" +
      ":normal! G\n" +
      ":execute \"normal! o\" . current_line\n" +
      ":execute \"normal! o\" . current_column\n"
    end

    def self.vim_close_commands
      "\n:%bd!\n:q!\n"
    end
  end
end
