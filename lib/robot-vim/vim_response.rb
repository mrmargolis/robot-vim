module RobotVim
  class VimResponse
    attr_reader :body, :column_number, :line_number
    def initialize(response_string)
      @response_string = response_string
      lines = @response_string.split("\n")
      @column_number = lines.pop.to_i
      @line_number = lines.pop.to_i
      @body = lines.join("\n")
    end
  end
end
