require "spec_helper"

describe DanceStylesController do
  describe "routing" do

    it "routes to #index" do
      get("/dance_styles").should route_to("dance_styles#index")
    end

    it "routes to #new" do
      get("/dance_styles/new").should route_to("dance_styles#new")
    end

    it "routes to #show" do
      get("/dance_styles/1").should route_to("dance_styles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dance_styles/1/edit").should route_to("dance_styles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dance_styles").should route_to("dance_styles#create")
    end

    it "routes to #update" do
      put("/dance_styles/1").should route_to("dance_styles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dance_styles/1").should route_to("dance_styles#destroy", :id => "1")
    end

  end
end
