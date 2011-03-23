module RobotVim
  class ScriptFile

    def self.open(commands)
      Tempfile.open('script_file') do |temp_file|
        temp_file << commands
        temp_file.flush
        yield temp_file.path
      end
    end

  end
end
