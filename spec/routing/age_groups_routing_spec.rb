require "spec_helper"

describe AgeGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/age_groups").should route_to("age_groups#index")
    end

    it "routes to #new" do
      get("/age_groups/new").should route_to("age_groups#new")
    end

    it "routes to #show" do
      get("/age_groups/1").should route_to("age_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/age_groups/1/edit").should route_to("age_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/age_groups").should route_to("age_groups#create")
    end

    it "routes to #update" do
      put("/age_groups/1").should route_to("age_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/age_groups/1").should route_to("age_groups#destroy", :id => "1")
    end

  end
end
