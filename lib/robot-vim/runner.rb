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
      output_file_name = UUID.new.generate(:compact)
      commands = args[:commands] + ":w #{output_file_name}"
      commands = commands + "\n:%bd!\n:q!\n"
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
  end
end
