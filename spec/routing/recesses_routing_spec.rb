require "spec_helper"

describe RecessesController do
  describe "routing" do

    it "routes to #index" do
      get("/recesses").should route_to("recesses#index")
    end

    it "routes to #new" do
      get("/recesses/new").should route_to("recesses#new")
    end

    it "routes to #show" do
      get("/recesses/1").should route_to("recesses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recesses/1/edit").should route_to("recesses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recesses").should route_to("recesses#create")
    end

    it "routes to #update" do
      put("/recesses/1").should route_to("recesses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recesses/1").should route_to("recesses#destroy", :id => "1")
    end

  end
end
