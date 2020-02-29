require "spec_helper"

describe MembersCoursesController do
  describe "routing" do

    it "routes to #index" do
      get("/members_courses").should route_to("members_courses#index")
    end

    it "routes to #new" do
      get("/members_courses/new").should route_to("members_courses#new")
    end

    it "routes to #show" do
      get("/members_courses/1").should route_to("members_courses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/members_courses/1/edit").should route_to("members_courses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/members_courses").should route_to("members_courses#create")
    end

    it "routes to #update" do
      put("/members_courses/1").should route_to("members_courses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/members_courses/1").should route_to("members_courses#destroy", :id => "1")
    end

  end
end
