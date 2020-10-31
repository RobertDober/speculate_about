description = "this file does not exist, surely!!"
RSpec.describe description do

  raised = false

  begin
    speculate_about description
  rescue ArgumentError => ae
    raised = ae.message
  end

  it "has been raised" do
    expect(raised).to eq("no files found for pattern #{description}")
  end

end
