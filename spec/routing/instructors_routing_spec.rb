require "spec_helper"

describe InstructorsController do
  describe "routing" do

    it "routes to #index" do
      get("/instructors").should route_to("instructors#index")
    end

    it "routes to #new" do
      get("/instructors/new").should route_to("instructors#new")
    end

    it "routes to #show" do
      get("/instructors/1").should route_to("instructors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/instructors/1/edit").should route_to("instructors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/instructors").should route_to("instructors#create")
    end

    it "routes to #update" do
      put("/instructors/1").should route_to("instructors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/instructors/1").should route_to("instructors#destroy", :id => "1")
    end

  end
end
