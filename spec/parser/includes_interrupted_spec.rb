require 'speculations/parser'
RSpec.describe Speculations::Parser do
  let(:fixture){ fixtures_path("INCLUDES_INTERRUPTED.md") }
  let(:parser) { described_class.new }
  let(:ast)    { parser.parse_from_file(fixture) }

  context "rendered code" do
    let(:expected_code) { File.readlines(fixtures_path("INCLUDES_INTERRUPTED_spec.rb.expected"), chomp: true) }
    let(:actual_code) { ast.to_code }

    it "they have the same lines" do
      actual_code.zip(expected_code).each_with_index do |(actual_line, expected_line), idx|
        expect("#{idx.succ}: #{actual_line}").to eq("#{idx.succ}: #{expected_line}")
      end
    end
  end
end
