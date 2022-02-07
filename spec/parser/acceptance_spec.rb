require 'speculations/parser'
RSpec.describe Speculations::Parser do
  let(:fixture){ fixtures_path("ACCEPTANCE.md") }
  let(:parser) { described_class.new }
  let(:ast)    { parser.parse_from_file(fixture) }

  context "root node" do
    it "has one child" do
      expect(ast.children).to be_one
    end
    describe "this only child" do
      let(:ctxt2) { ast.children.first }
      it "has level 2" do
        expect(ctxt2.level).to eq(2)
      end
      it "has tree_level 1" do
        expect(ctxt2.tree_level).to eq(1)
      end
      it "has one child" do
        expect(ctxt2.children).to be_one
      end
      it "has no includes" do
        expect(ctxt2.includes).to be_empty
      end
      it "has one example" do
        expect(ctxt2.examples).to be_one
      end
      it "which contains the correct title" do
        expect(ctxt2.examples.first.title).to eq("therefore we have (spec/fixtures/ACCEPTANCE.md:35)")
      end
      it "and is correctly rendered" do
        expect(ctxt2.examples.first.to_code)
          .to eq([
                   "    it \"therefore we have (spec/fixtures/ACCEPTANCE.md:35)\" do",
                   "      a nice example # We do not check the code, RSpec will do that for us", "    end"
                 ])
      end
    end
  end

  context "leaf node" do
    let(:ctxt3) { ast.children.first.children.first }
    it "has level 3" do
      expect(ctxt3.level).to eq(3)
    end
    it "has tree_level 2" do
      expect(ctxt3.tree_level).to eq(2)
    end
    it "has no children" do
      expect(ctxt3.children).to be_empty
    end
    it "has one include" do
      expect(ctxt3.includes).to be_one
    end
    it "has one example" do
      expect(ctxt3.examples).to be_one
    end
    it "which contains the correct title" do
      expect(ctxt3.examples.first.title).to eq("this shall be (spec/fixtures/ACCEPTANCE.md:23)")
    end
    it "and is correctly rendered" do
      expect(ctxt3.examples.first.to_code)
        .to eq(
          ["      it \"this shall be (spec/fixtures/ACCEPTANCE.md:23)\" do",
           "        expect( 1 ).to be_zero # Who cares?", "      end"]
        )
    end
  end

  context "rendered code" do
    let(:expected_code) { File.readlines(fixtures_path("ACCEPTANCE_spec.rb.expected"), chomp: true) }
    let(:actual_code) { ast.to_code }

    it "has no superflous lines" do
      expect(actual_code.size).to eq(expected_code.size)
    end

    it "they have the same lines" do
      actual_code.zip(expected_code).each_with_index do |(actual_line, expected_line), idx|
        expect("#{idx.succ}: #{actual_line}").to eq("#{idx.succ}: #{expected_line}")
      end
    end
  end
end
