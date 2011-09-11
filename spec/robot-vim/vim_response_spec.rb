require 'spec_helper'

describe RobotVim::VimResponse do
  let(:expected_body) { "hi there.  This is some stuff.\n That is in vim\n and might be awesome" } 
  let(:expected_line) { 2 } 
  let(:expected_column) { 4 } 
  let(:file_contents) { expected_body + "\n" + expected_line.to_s + "\n" + expected_column.to_s }

  subject { RobotVim::VimResponse.new(file_contents) }

  its(:body) { should == expected_body }
  its(:line_number) { should == expected_line }
  its(:column_number) { should == expected_column }
end
