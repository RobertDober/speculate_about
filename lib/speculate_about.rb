require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    path = _find_file(file)
    code = _compile path
    ENV["SPECULATE_ABOUT_DEBUG"] ? puts(code) : instance_eval(code)
  end


  private

  def _compile path
    ast  = Speculations::Parser.new.parse_from_file(path)
    ast.to_code
  end
  def _find_file file
    return file if File.readable? file
    raise ArgumentError, "file #{file.inspect} not found"
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
