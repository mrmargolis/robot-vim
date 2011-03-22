require 'rspec'
require File.join(File.dirname(__FILE__), '/../lib/robot-vim.rb')

Rspec.configure do |c|
  c.mock_with :rspec
end
