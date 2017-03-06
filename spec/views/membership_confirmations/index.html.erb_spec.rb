require 'rails_helper'

RSpec.describe "membership_confirmations/index", type: :view do
  before(:each) do
    assign(:membership_confirmations, [
      MembershipConfirmation.create!(
        :user_id => 1,
        :beer_club_id => 2
      ),
      MembershipConfirmation.create!(
        :user_id => 1,
        :beer_club_id => 2
      )
    ])
  end

  it "renders a list of membership_confirmations" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
