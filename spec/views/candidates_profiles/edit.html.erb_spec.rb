require 'spec_helper'

describe "candidates_profiles/edit" do
  before(:each) do
    @candidates_profile = assign(:candidates_profile, stub_model(CandidatesProfile,
      :tag_name => "MyString",
      :tag_type => 1,
      :profiles_id => 1
    ))
  end

  it "renders the edit candidates_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", candidates_profile_path(@candidates_profile), "post" do
      assert_select "input#candidates_profile_tag_name[name=?]", "candidates_profile[tag_name]"
      assert_select "input#candidates_profile_tag_type[name=?]", "candidates_profile[tag_type]"
      assert_select "input#candidates_profile_profiles_id[name=?]", "candidates_profile[profiles_id]"
    end
  end
end
