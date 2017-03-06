require 'rails_helper'

RSpec.describe "MembershipConfirmations", type: :request do
  describe "GET /membership_confirmations" do
    it "works! (now write some real specs)" do
      get membership_confirmations_path
      expect(response).to have_http_status(200)
    end
  end
end
