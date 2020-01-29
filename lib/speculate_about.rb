require 'rspec'

module SpeculateAbout
  def speculate_about file
    p File.join(file, File.dirname(location))
    instance_eval( 'let(:value){ 42 }' )
    before do
      instance_eval( '@half = value / 2' )
    end
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
