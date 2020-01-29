require 'speculations/parser'
RSpec.describe Speculations::Parser do
  let(:parser) { described_class.new }

  context "SPECULATION1" do
    let!(:ast) do
      parser.parse_from_file(
        fixtures_path("SPECULATION1.md")
      )
    end

    context "root node" do
      it "has 3 children" do
        expect(ast.children.map(&:name)).to eq([
          "no config", "with config", "without `@half`, overriding value"
        ])
      end
      it "has one include" do
        expect(ast.includes.map(&:lines)).to eq([["  let(:value){ 42 }"]])
      end
    end

    context "first context" do
      let(:context){ ast.children.first }

      it "has no includes" do
        expect(context.includes).to be_empty
      end

      it "and no setup" do
        expect(context.setup).to be_nil
      end

      it "and one example" do
        expect(context.examples.map(&:lines)).to eq([
          ["  expect(value).to eq(42)"]
        ])
        expect(context.examples.first.name).to eq("Example  at line 19")
      end
    end

    context "second context" do
      let(:context){ ast.children[1] }

      it "has no includes" do
        expect(context.includes).to be_empty
      end

      it "has one example" do
        expect(context.examples.map(&:lines)).to eq([
          ["  expect(@half).to eq(42)"]
        ])
        expect(context.examples.first.name).to eq("Example  at line 33")
      end

      it "has a setup" do
        expect(context.setup.lines).to eq(["  @half = value / 2"])
      end
    end

    context "third context" do
      let(:context){ ast.children.last }

      it "has one include" do
        expect(context.includes.map(&:lines)).to eq([["  let(:value){ 0 }"]])
      end

      it "and no setup" do
        expect(context.setup).to be_nil
      end

      it "has two examples" do
        expect(context.examples.map(&:lines)).to eq([
          ["  expect(@half).to be_nil"],
          ["  expect(value).to be_zero"]
        ])
        expect(context.examples.map(&:name)).to eq(["Example  at line 44", "Example  at line 47"])
      end
    end
  end
end
