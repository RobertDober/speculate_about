RSpec.describe "this file does not exist, surely!!" do

  raised = false
  
  begin
    speculate_about description
  rescue ArgumentError => ae
    raised =
      ae.message == "file this file does not exist, surely!! neither found in your project dir, neither your spec dir"
  end

  it "has been raised" do
    expect(raised).to be_truthy
  end

end
