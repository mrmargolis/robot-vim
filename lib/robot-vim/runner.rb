module RobotVim
  class Runner
    DEFAULT_VIM_BINARY = "vim"
    DEFAULT_VIMRC = "~/.vimrc"

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
      ScriptFile.open(args[:commands]) do |script_file_path|
        Kernel.send(:`, "#{self.vim_binary} -n -u #{self.vimrc} -s #{script_file_path} #{args[:input_file]}")
      end
    end
  end
end
