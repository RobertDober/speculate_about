require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    path = _find_file(file, File.dirname( caller.first ))
    code = _compile path, file
    ENV["SPECULATE_ABOUT_DEBUG"] ? puts(code) : instance_eval(code)
  end


  private

  def _compile path, file
    ast  = Speculations::Parser.new.parse_from_file(path, file)
    ast.to_code
  end
  def _find_file file, local_path
    return file if File.readable? file
    local_file = File.join(local_path, file)
    return local_file if File.readable? local_file
    raise ArgumentError, "file #{file.inspect} not found"
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
