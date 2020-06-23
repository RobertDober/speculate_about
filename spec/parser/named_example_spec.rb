require 'speculations/parser'
RSpec.describe Speculations::Parser do

  let(:parser) { described_class.new }
  let(:fixture){ fixtures_path("NAMED_EXAMPLE.md") }

  let!(:ast)   { parser.parse_from_file(fixture, "NAMED_EXAMPLE.md") }

  context "SPECULATION -> ast" do

    context "root node" do
      it "has 3 examples" do
        expect(ast.examples.map(&:name))
          .to eq([
            "With a nifty name (NAMED_EXAMPLE.md:4)",
            "Name comes from outside (NAMED_EXAMPLE.md:10)",
            "Example from NAMED_EXAMPLE.md:15"
        ])
      end
    end
  end

end
