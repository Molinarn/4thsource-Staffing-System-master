require 'spec_helper'

describe CandidateProfilesController do

  describe "GET 'New'" do
    it "returns http success" do
      get 'New'
      response.should be_success
    end
  end

end
