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
      ScriptFile.open(args[:commands]) do |script_file_path|
        Kernel.send(:`, "#{self.vim_binary} -n -s #{script_file_path} #{args[:input_file]}")
      end
    end
  end
end
