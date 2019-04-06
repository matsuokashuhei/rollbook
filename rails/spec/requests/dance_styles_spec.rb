require 'spec_helper'

describe "DanceStyles" do
  describe "GET /dance_styles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dance_styles_path
      response.status.should be(200)
    end
  end
end
