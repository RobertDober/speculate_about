RSpec.describe "Speculations v1" do
  speculate_about "V1.md"

  it "The include from V1 was correctly included" do
    expect( value ).to eq(42)
  end

  it "Also executes setups" do
    expect( @half ).to eq(21)
  end

end
