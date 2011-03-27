module RobotVim
  class InputFile
    def self.path_for(input, &block)
      if File.exists?(input)
        yield_existing_file_path(input, block)
      else
        yield_on_demand_file_path(input, block)
      end
    end


    def self.yield_existing_file_path(input, block)
      block.call(input)
    end

    def self.yield_on_demand_file_path(input, block)
      file_name = FileNameGenerator.generate
      File.open(file_name, "w+") do |file|
        file << input
      end
      block.call(file_name)
    ensure
      File.delete(file_name)
    end
  end
end
