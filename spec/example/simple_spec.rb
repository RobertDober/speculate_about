RSpec.describe "Simple Spec" do
  context "minimum" do
    let(:values){ [] }
    before do
      values << 42
    end
    it "is not empty" do
      expect( values.first ).to eq(42)
    end
  end
end
