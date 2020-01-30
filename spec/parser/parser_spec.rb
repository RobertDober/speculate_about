require 'speculations/parser'
RSpec.describe Speculations::Parser do

  let(:parser) { described_class.new }
  let(:fixture){ fixtures_path("SPECULATION1.md") }

  let!(:ast)   { parser.parse_from_file(fixture) }

  context "SPECULATION1 -> ast" do

    context "root node" do
      it "has 3 children" do
        expect(ast.children.map(&:name)).to eq([
          "no config", "with config", "without `@half`, overriding value"
        ])
      end
      it "is at level 1" do
        expect(ast.level).to eq(1)
      end

      it "has one include" do
        expect(ast.includes.map(&:lines)).to eq([["  let(:value){ 42 }"]])
      end
      
      it "has no examples" do
        expect(ast.examples).to be_empty
      end

      it "has no setup" do
        expect(ast.setup).to be_nil
      end
    end

    context "first context" do
      let(:context){ ast.children.first }

      it "is at level 2" do
        expect(context.level).to eq(2)
      end

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
        expect(context.examples.first.name).to eq(example_location(20))
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
        expect(context.examples.first.name).to eq(example_location(34))
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
        expect(context.examples.map(&:name)).to eq([45, 48].map(&method(:example_location)))
      end
    end
  end

  context "ast -> code" do
    context "includes" do
      let(:include1) { ast.includes.first }
      let(:include2) { ast.children.last.includes.first }
      it "first include renders at first level" do
        expect( include1.to_code ).to eq("  let(:value){ 42 }")
      end
      it "last include renders a level deeper" do
        expect( include2.to_code ).to eq("    let(:value){ 0 }")
      end
    end

    context "setups" do
      let(:setup) { ast.children[1].setup }
      it "renders at level 2 inside a before block" do
        expect( setup.to_code ).to eq([
          "    before do",
          "      @half = value / 2",
          "    end"
        ].join("\n"))
      end
    end

    context "examples" do
      let(:example1) { ast.children.first.examples.first  }
      let(:example2) { ast.children[1].examples.first }
      let(:example3) { ast.children.last.examples.first }
      let(:example4) { ast.children.last.examples.last }

      it "renders example1" do
        expect(example1.to_code).to eq([
          %[    it "#{example_location 20}" do],
          %[      expect(value).to eq(42)],
          %{    end}
        ].join("\n"))
      end

    end

  end

  context "putting it all together" do

    context "a sub context" do
      let(:context) { ast.children.first }
      let(:expected) do
        <<-EOCODE
  context "no config" do
    it "#{example_location 20}" do
      expect(value).to eq(42)
    end
  end
        EOCODE
      end
      it "renders correctly" do
        expect(context.to_code).to eq(expected.chomp)
      end
    end

    context "root context, rendering of all speculations from a file" do
      let(:expected) do
        <<~EOCODE
        context "Speculations from #{fixture}" do
          let(:value){ 42 }
          context "no config" do
            it "#{example_location 20}" do
              expect(value).to eq(42)
            end
          end
          context "with config" do
            before do
              @half = value / 2
            end
            it "#{example_location 34}" do
              expect(@half).to eq(42)
            end
          end
          context "without `@half`, overriding value" do
            let(:value){ 0 }
            it "#{example_location 45}" do
              expect(@half).to be_nil
            end
            it "#{example_location 48}" do
              expect(value).to be_zero
            end
          end
        end
        EOCODE
      end

      it "renders the following:" do
        expect(ast.to_code).to eq(expected.chomp)
      end
    end

  end

  def example_location lnb
    ["Example from #{fixture}", lnb].join(":")
  end
end
