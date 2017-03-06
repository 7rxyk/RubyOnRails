require "rails_helper"

RSpec.describe MembershipConfirmationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/membership_confirmations").to route_to("membership_confirmations#index")
    end

    it "routes to #new" do
      expect(:get => "/membership_confirmations/new").to route_to("membership_confirmations#new")
    end

    it "routes to #show" do
      expect(:get => "/membership_confirmations/1").to route_to("membership_confirmations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/membership_confirmations/1/edit").to route_to("membership_confirmations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/membership_confirmations").to route_to("membership_confirmations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/membership_confirmations/1").to route_to("membership_confirmations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/membership_confirmations/1").to route_to("membership_confirmations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/membership_confirmations/1").to route_to("membership_confirmations#destroy", :id => "1")
    end

  end
end
