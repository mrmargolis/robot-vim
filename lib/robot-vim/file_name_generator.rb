module RobotVim
  class FileNameGenerator
    def self.generate
      UUID.new.generate(:compact)
    end
  end
end
