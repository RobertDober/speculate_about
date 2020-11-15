require 'speculations/parser'
RSpec.describe Speculations::Parser do

  let(:parser) { described_class.new }
  let(:fixture){ fixtures_path("ALTERNATE_SYNTAX.md") }

  let!(:ast)   { parser.parse_from_file(fixture, "ALTERNATE_SYNTAX", alternate_syntax: true) }

  context "SPECULATION -> ast" do

    context "root node" do
      it "has one example" do
        expect(ast.examples.map(&:name))
          .to eq( ["A nifty name (ALTERNATE_SYNTAX:7)"])
      end
      it "has one context" do
        expect( ast.children.size ).to eq(1)
      end
      it "and no includes" do
        expect( ast.includes ).to be_empty
      end
    end

    context "subcontext" do
      let(:subcontext) { ast.children.first }

      it "has two examples" do
        expect( subcontext.examples.map(&:name) )
          .to eq(["(now triggers an example, too) (ALTERNATE_SYNTAX:30)", "Another one (ALTERNATE_SYNTAX:37)"])
      end

      it "has no subcontexts" do
        expect( subcontext.children ).to be_empty
      end

      it "has one include" do
        expect( subcontext.includes.map(&:to_code) )
          .to eq(["    let(:variable) { true }"]) 
      end

      it "...with the correct line number, of course" do
        expect(subcontext.includes.first.lnb).to eq(24)
      end
      
    end
  end

end
