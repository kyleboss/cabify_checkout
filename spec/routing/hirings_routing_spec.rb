require "rails_helper"

RSpec.describe HiringsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hirings").to route_to("hirings#index")
    end

    it "routes to #new" do
      expect(:get => "/hirings/new").to route_to("hirings#new")
    end

    it "routes to #show" do
      expect(:get => "/hirings/1").to route_to("hirings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hirings/1/edit").to route_to("hirings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hirings").to route_to("hirings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hirings/1").to route_to("hirings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hirings/1").to route_to("hirings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hirings/1").to route_to("hirings#destroy", :id => "1")
    end

  end
end
