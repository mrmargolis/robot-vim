module RobotVim
  class ScriptFile

    def self.open(commands)
      file_name = UUID.new.generate(:compact)
      script_file = File.new(file_name, "w")
      script_file << commands
      script_file.flush
      script_file.close
      yield file_name
    ensure
      File.delete(file_name) if File.exists?(file_name)
    end

  end
end
