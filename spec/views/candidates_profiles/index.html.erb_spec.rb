require 'spec_helper'

describe "candidates_profiles/index" do
  before(:each) do
    assign(:candidates_profiles, [
      stub_model(CandidatesProfile,
        :tag_name => "Tag Name",
        :tag_type => 1,
        :profiles_id => 2
      ),
      stub_model(CandidatesProfile,
        :tag_name => "Tag Name",
        :tag_type => 1,
        :profiles_id => 2
      )
    ])
  end

  it "renders a list of candidates_profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tag Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
