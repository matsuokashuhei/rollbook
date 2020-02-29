require "spec_helper"

describe TimetablesController do
  describe "routing" do

    it "routes to #index" do
      get("/timetables").should route_to("timetables#index")
    end

    it "routes to #new" do
      get("/timetables/new").should route_to("timetables#new")
    end

    it "routes to #show" do
      get("/timetables/1").should route_to("timetables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/timetables/1/edit").should route_to("timetables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/timetables").should route_to("timetables#create")
    end

    it "routes to #update" do
      put("/timetables/1").should route_to("timetables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/timetables/1").should route_to("timetables#destroy", :id => "1")
    end

  end
end
