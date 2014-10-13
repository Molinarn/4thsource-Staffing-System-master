require 'spec_helper'

describe "candidates_profiles/show" do
  before(:each) do
    @candidates_profile = assign(:candidates_profile, stub_model(CandidatesProfile,
      :tag_name => "Tag Name",
      :tag_type => 1,
      :profiles_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tag Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
