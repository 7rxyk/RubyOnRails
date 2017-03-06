require 'rails_helper'

RSpec.describe "membership_confirmations/show", type: :view do
  before(:each) do
    @membership_confirmation = assign(:membership_confirmation, MembershipConfirmation.create!(
      :user_id => 1,
      :beer_club_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
