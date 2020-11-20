require 'speculations/parser'
RSpec.describe Speculations::Parser do

  let(:parser) { described_class.new }
  let(:fixture){ fixtures_path("MIXED_FEELINGS.md") }

  let!(:ast)   { parser.parse_from_file(fixture, "ALTERNATE_SYNTAX_MIXED", alternate_syntax: true) }

  context "SPECULATION -> ast" do

    context "root node" do
      it "has one example" do
        expect(ast.examples.map(&:name)).to eq(["that holds for construction too (ALTERNATE_SYNTAX_MIXED:4)"])
      end
      it "has one include" do
        expect( ast.includes.size ).to eq(1)
      end
    end
  end
end
