require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    path = find_file(file)
    ast = Speculations::Parser.new.parse_from_file(path)
    instance_eval ast.to_code
  end

  private
  def find_file file
    return file if File.readable? file
    path = File.join(File.dirname(location), file)
    return path if File.readable? path
    raise ArgumentError, "file #{file} neither found in your project dir, neither your spec dir"
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
