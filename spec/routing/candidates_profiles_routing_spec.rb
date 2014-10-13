require "spec_helper"

describe CandidatesProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/candidates_profiles").should route_to("candidates_profiles#index")
    end

    it "routes to #new" do
      get("/candidates_profiles/new").should route_to("candidates_profiles#new")
    end

    it "routes to #show" do
      get("/candidates_profiles/1").should route_to("candidates_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/candidates_profiles/1/edit").should route_to("candidates_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/candidates_profiles").should route_to("candidates_profiles#create")
    end

    it "routes to #update" do
      put("/candidates_profiles/1").should route_to("candidates_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/candidates_profiles/1").should route_to("candidates_profiles#destroy", :id => "1")
    end

  end
end
