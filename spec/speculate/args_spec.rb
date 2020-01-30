require 'speculate/args'
RSpec.describe Speculate::Args do
  context "empty gracefully supports all methods" do
    let(:args) { described_class.new([]) }

    it "does not have any flag" do
      any_names(to_sym: true) do |name|
        expect( args.flag?(name) ).to be_nil
      end
    end
    
    it "or keyword for any matter" do
      any_names(to_sym: true) do |name|
        expect( args.fetch(name) ).to be_nil
      end
    end

    it "does not fail on destructive queries" do
      expect( args.fetch!(any_name) ).to be_nil
      expect( args.flag!(any_name) ).to be_nil
      expect( args ).to be_empty
      expect( args.to_a ).to be_empty
    end
  end

  context "but work needs to be done, right?" do
    let(:input) { %w[12 a: 42 13 :flag b:] }

    let(:args) { described_class.new(input) }

    it "gets us the args back" do
      expect( args.to_a ).to eq(input)
    end

    it "we can access positionals" do
      expect( args.positionals ).to eq(%w[12 13])
    end

    it "we can access keywords" do
      expect( args.fetch(:a) ).to eq("42")
      expect( args.fetch(:a,&:to_i) ).to eq(42)
    end

    it "we can access keywords destructively" do
      expect( args.fetch!(:a,&:to_i) ).to eq(42)
      expect( args.fetch(:a) ).to be_nil
    end

  end
end
