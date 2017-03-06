require 'rails_helper'

RSpec.describe "membership_confirmations/new", type: :view do
  before(:each) do
    assign(:membership_confirmation, MembershipConfirmation.new(
      :user_id => 1,
      :beer_club_id => 1
    ))
  end

  it "renders new membership_confirmation form" do
    render

    assert_select "form[action=?][method=?]", membership_confirmations_path, "post" do

      assert_select "input#membership_confirmation_user_id[name=?]", "membership_confirmation[user_id]"

      assert_select "input#membership_confirmation_beer_club_id[name=?]", "membership_confirmation[beer_club_id]"
    end
  end
end
