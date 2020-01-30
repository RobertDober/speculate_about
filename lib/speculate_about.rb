require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    path = File.join(File.dirname(location), file)
    ast = Speculations::Parser.new.parse_from_file(path)
    innstance_eval ast.to_code
    # instance_eval( 'let(:value){ 42 }' )
    # before do
    #   instance_eval( '@half = value / 2' )
    # end
    # Actual code
    # parsed = parse(path)
    # parsed.chunks.each hk
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
