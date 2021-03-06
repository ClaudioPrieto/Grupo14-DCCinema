=begin
require "rails_helper"

RSpec.describe MovieInstancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/movie_instances").to route_to("movie_instances#index")
    end

    it "routes to #new" do
      expect(get: "/movie_instances/new").to route_to("movie_instances#new")
    end

    it "routes to #show" do
      expect(get: "/movie_instances/1").to route_to("movie_instances#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/movie_instances/1/edit").to route_to("movie_instances#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/movie_instances").to route_to("movie_instances#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/movie_instances/1").to route_to("movie_instances#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/movie_instances/1").to route_to("movie_instances#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/movie_instances/1").to route_to("movie_instances#destroy", id: "1")
    end
  end
end
=end
