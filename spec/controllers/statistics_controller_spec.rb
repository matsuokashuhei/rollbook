require 'spec_helper'

describe StatisticsController do

  describe "GET 'data'" do
    it "returns http success" do
      get 'data'
      response.should be_success
    end
  end

end
