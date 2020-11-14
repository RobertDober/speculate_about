require 'speculations/parser'
RSpec.describe Speculations::Parser do

  let(:parser) { described_class.new }
  let(:fixture){ fixtures_path("ALTERNATE_SYNTAX.md") }

  let!(:ast)   { parser.parse_from_file(fixture, "ALTERNATE_SYNTAX", alternate_syntax: true) }

  context "SPECULATION -> ast" do

    context "root node" do
      it "has 2 examples" do
        expect(ast.examples.map(&:name))
          .to eq( ["A nifty name (ALTERNATE_SYNTAX:7)", "Another one (ALTERNATE_SYNTAX:21)"])
      end
    end
  end

end
