require "rails_helper"

RSpec.describe CheckoutsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/checkouts").to route_to("checkouts#index")
    end

    it "routes to #new" do
      expect(:get => "/checkouts/new").to route_to("checkouts#new")
    end

    it "routes to #show" do
      expect(:get => "/checkouts/1").to route_to("checkouts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/checkouts/1/edit").to route_to("checkouts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/checkouts").to route_to("checkouts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/checkouts/1").to route_to("checkouts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/checkouts/1").to route_to("checkouts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/checkouts/1").to route_to("checkouts#destroy", :id => "1")
    end

  end
end
