require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
	  
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "shows ratings" do
    user = User.first
    visit user_path(user)
    expect(page).to have_content 'has made 0 ratings'

    brewery = Brewery.create name: "Brewery", year: 2000

    beer = Beer.create name: "Test", style: "Lager", brewery_id: brewery.id
    Rating.create score: 20, beer_id: beer.id, user_id: user.id
    visit user_path(user)
    expect(page).to have_content 'Test 20'

    beertwo = Beer.create name: "MegaBeer", style: "Lager"
    Rating.create score: 18, beer_id: beertwo.id, user_id: user.id
    visit user_path(user)
    expect(page).to have_content 'MegaBeer 18'
  end

  it "shows favourite brewery" do
    user = User.first
    visit user_path(user)

    brewery = Brewery.create name: "SuperBrewery", year: 2000

    beer = Beer.create name: "Test", style: "Lager", brewery_id: brewery.id
    Rating.create score: 20, beer_id: beer.id, user_id: user.id
    visit user_path(user)
    expect(page).to have_content 'SuperBrewery'
  end

  it "shows favourite style" do
    user = User.first
    visit user_path(user)

    brewery = Brewery.create name: "SuperBrewery", year: 2000

    beer = Beer.create name: "Test", style: "Lager", brewery_id: brewery.id
    Rating.create score: 20, beer_id: beer.id, user_id: user.id
    visit user_path(user)
    expect(page).to have_content 'Lager'
  end

  it "allows deleting ratings" do
    sign_in(username: "Pekka", password: "Foobar1")
    brewery = Brewery.create name: "Brewery", year: 2000
    user = User.first
    beer = Beer.create name: "Test", style: "Lager", brewery_id: brewery.id
    Rating.create score: 20, beer_id: beer.id, user_id: user.id
    visit user_path(user)
    expect {
      click_on('delete')
    }.to change { Rating.count }.by(-1)
	
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect {
      click_button('Create User')
    }.to change { User.count }.by(1)
  end
end