require "rails_helper"

RSpec.describe StulecturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/stulectures").to route_to("stulectures#index")
    end

    it "routes to #new" do
      expect(:get => "/stulectures/new").to route_to("stulectures#new")
    end

    it "routes to #show" do
      expect(:get => "/stulectures/1").to route_to("stulectures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/stulectures/1/edit").to route_to("stulectures#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/stulectures").to route_to("stulectures#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/stulectures/1").to route_to("stulectures#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/stulectures/1").to route_to("stulectures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/stulectures/1").to route_to("stulectures#destroy", :id => "1")
    end

  end
end
