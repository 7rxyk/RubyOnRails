require 'rails_helper'

describe "Beers page" do

  include Helpers

  it "allows creating a beer with valid info" do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    Brewery.create name: "Brewery", year: 1994
    visit new_beer_path
    fill_in('beer_name', with:'BeerName')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "disallows creating a beer with invvalid info and displays error" do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    Brewery.create name: "Brewery", year: 1994
    visit new_beer_path
    fill_in('beer_name', with:'')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content 'prohibited this beer from being saved'
  end

end