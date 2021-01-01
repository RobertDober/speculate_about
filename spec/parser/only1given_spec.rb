require 'speculations/parser'
RSpec.describe Speculations::Parser do

  let(:parser) { described_class.new }
  let(:ast)   { parser.parse_from_file(fixture) }

  context "one given only" do
    let(:fixture){ fixtures_path("ONLY1GIVEN.md") }
    it "has no child contexts" do
      expect( ast.children ).to be_empty
    end

    it "has no examples" do
      expect( ast.examples ).to be_empty
    end

    it "has one include" do
      expect( ast.includes.size ).to eq(1)
    end

    describe "its include" do
      let(:incl) { ast.includes.first }
      
      it "has the correct lnb" do 
        expect( incl.lnb ).to eq(3)
      end

      it "has the correct parent" do
        expect( incl.parent ).to eq(ast)
      end

      it "has the correct representation as code" do
        expect( incl.to_code ).to eq(["  # spec/fixtures/ONLY1GIVEN.md:3", "  x = 42"])
      end
    end
  end
end
