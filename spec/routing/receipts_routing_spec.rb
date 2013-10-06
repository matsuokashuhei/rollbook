require "spec_helper"

describe ReceiptsController do
  describe "routing" do

    it "routes to #index" do
      get("/receipts").should route_to("receipts#index")
    end

    it "routes to #new" do
      get("/receipts/new").should route_to("receipts#new")
    end

    it "routes to #show" do
      get("/receipts/1").should route_to("receipts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/receipts/1/edit").should route_to("receipts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/receipts").should route_to("receipts#create")
    end

    it "routes to #update" do
      put("/receipts/1").should route_to("receipts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/receipts/1").should route_to("receipts#destroy", :id => "1")
    end

  end
end
