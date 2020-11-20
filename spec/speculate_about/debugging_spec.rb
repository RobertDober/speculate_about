RSpec.describe "spec/fixtures/SIMPLE.md" do
  old_stdout = $stdout
  stdout = StringIO.new
  $stdout = stdout
  ENV["SPECULATE_ABOUT_DEBUG"]="1"
  speculate_about description, alternate_syntax: true

  it "has output the code correctly" do
    expected_output = <<EOS 
Generated code for #{ENV["HOME"]}/gh/ruby/speculate_about/spec/fixtures/SIMPLE.md
================================================================================
context \"Speculations from #{ENV["HOME"]}/gh/ruby/speculate_about/spec/fixtures/SIMPLE.md\" do
  x = 42
end
EOS
    expect( stdout.string ).to eq(expected_output)
  end
ensure
  $stdout = old_stdout
  ENV["SPECULATE_ABOUT_DEBUG"]=nil
end
