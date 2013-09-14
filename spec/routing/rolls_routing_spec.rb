require "spec_helper"

describe RollsController do
  describe "routing" do

    it "routes to #index" do
      get("/rolls").should route_to("rolls#index")
    end

    it "routes to #new" do
      get("/rolls/new").should route_to("rolls#new")
    end

    it "routes to #show" do
      get("/rolls/1").should route_to("rolls#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rolls/1/edit").should route_to("rolls#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rolls").should route_to("rolls#create")
    end

    it "routes to #update" do
      put("/rolls/1").should route_to("rolls#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rolls/1").should route_to("rolls#destroy", :id => "1")
    end

  end
end
