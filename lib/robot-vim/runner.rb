module RobotVim
  class Runner
    DEFAULT_VIM_BINARY = "vim"

    def initialize(args={})
      @vim_binary = args[:vim]
    end

    def vim_binary
      @vim_binary || DEFAULT_VIM_BINARY
    end

    def run(args={})
      output_file_name = RobotVim::FileNameGenerator.generate
      commands = args[:commands] + output_write_command(output_file_name) + vim_close_commands
      invoke_vim(commands, args[:input_file])
      return File.read(output_file_name)
    ensure
      File.delete(output_file_name) if File.exists?(output_file_name)
    end

    private
    
    def invoke_vim(commands, input_file)
      ScriptFile.open(commands) do |script_file_path|
        Kernel.send(:`, "#{self.vim_binary} -n -s #{script_file_path} #{input_file}")
      end
    end

    def output_write_command(output_file_name)
      ":w #{output_file_name}"
    end

    def vim_close_commands
      "\n:%bd!\n:q!\n"
    end
  end
end
