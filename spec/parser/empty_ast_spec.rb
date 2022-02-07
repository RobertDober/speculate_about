require 'speculations/parser'
RSpec.describe Speculations::Parser do
  let(:parser) { described_class.new }
  let!(:ast)   { parser.parse_from_file(fixture) }

  shared_examples_for "no speculations found" do
    it "has no child contexts" do
      expect(ast.children).to be_empty
    end

    it "has no examples" do
      expect(ast.examples).to be_empty
    end

    it "has no includes" do
      expect(ast.includes).to be_empty
    end
  end

  context "an empty file is parsed correctly" do
    let(:fixture){ fixtures_path("EMPTY.md") }
    it_behaves_like "no speculations found"
  end

  context "a file with some markdown, but no speculations" do
    let(:fixture){ fixtures_path("MARKDOWN_WO_SPECULATIONS.md") }
    it_behaves_like "no speculations found"
  end
end
