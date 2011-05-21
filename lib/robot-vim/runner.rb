module RobotVim
  class Runner
    DEFAULT_VIM_BINARY = "vim"
    DEFAULT_VIMRC = File.join(File.expand_path("~"), ".vimrc")

    def initialize(args={})
      @vim_binary = args[:vim]
      @vimrc = args[:vimrc]
    end

    def vim_binary
      @vim_binary || DEFAULT_VIM_BINARY
    end

    def vimrc
      @vimrc || DEFAULT_VIMRC
    end

    def run(args={})
      output_file_name = RobotVim::FileNameGenerator.generate
      commands = args[:commands] + output_write_command(output_file_name) + vim_close_commands

      InputFile.path_for(args[:input_file]) do |input_file_path|
        ScriptFile.open(commands) do |script_file_path|
          invoke_vim(script_file_path, input_file_path)
        end
      end

      return read_output_file_contents(output_file_name)
    ensure
      File.delete(output_file_name) if File.exists?(output_file_name)
    end

    private

    def invoke_vim(script_file_path, input_file)
      Kernel.send(:`, "#{self.vim_binary} -N -n -u #{self.vimrc} -s #{script_file_path} #{input_file} 2>/dev/null")
    end

    def output_write_command(output_file_name)
      ":w #{output_file_name}"
    end

    def vim_close_commands
      "\n:%bd!\n:q!\n"
    end

    def read_output_file_contents(output_file_name)
      File.read(output_file_name)
    end
  end
end
