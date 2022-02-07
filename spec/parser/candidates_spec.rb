require 'speculations/parser'
RSpec.describe Speculations::Parser do
  let(:parser) { described_class.new }
  let!(:ast)   { parser.parse_from_file(fixture) }
  let(:fixture){ fixtures_path("CANDIDATES.md") }

  describe "has one child context" do
    it { expect(ast.children).to be_one }
  end

  it "has no examples" do
    expect(ast.examples).to be_empty
  end

  describe "has one include" do
    let(:incl) { ast.children.first }
    it { expect(incl.includes).to be_one }
    it "has correct text" do
      expect(incl.includes.first.to_code).to eq(["    # spec/fixtures/CANDIDATES.md:8", "    blah"])
    end
  end
end
