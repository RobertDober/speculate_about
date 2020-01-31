require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    path = File.join(File.dirname(location), file)
    ast = Speculations::Parser.new.parse_from_file(path)
    instance_eval ast.to_code
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
