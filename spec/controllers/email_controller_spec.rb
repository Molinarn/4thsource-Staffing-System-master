require 'spec_helper'

describe EmailController do

  describe "GET 'remind'" do
    it "returns http success" do
      get 'remind'
      response.should be_success
    end
  end

end
