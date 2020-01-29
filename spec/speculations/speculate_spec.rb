RSpec.describe "spec/speculations/SPECULATE.md" do
describe Speculate do
  let(:value) { 42 }
  let(:subject){ described_class }
  it 'is a module' do
    expect( subject ).to be_kind_of(Module)
  end
  it 'of great value' do
    expect(value).to eq(42)
  end
end
end
