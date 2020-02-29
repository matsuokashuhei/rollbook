require "spec_helper"

describe AccessLogsController do
  describe "routing" do

    it "routes to #index" do
      get("/access_logs").should route_to("access_logs#index")
    end

    it "routes to #new" do
      get("/access_logs/new").should route_to("access_logs#new")
    end

    it "routes to #show" do
      get("/access_logs/1").should route_to("access_logs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/access_logs/1/edit").should route_to("access_logs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/access_logs").should route_to("access_logs#create")
    end

    it "routes to #update" do
      put("/access_logs/1").should route_to("access_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/access_logs/1").should route_to("access_logs#destroy", :id => "1")
    end

  end
end
