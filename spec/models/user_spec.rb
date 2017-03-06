require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has the username set correctly' do
    user = User.new username: 'Pekka'

    user.username.should == 'Pekka'
  end
  it 'is not saved without a password' do
    user = User.create username: 'Pekka'

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end
  it 'is saved with a proper password' do
    user = User.create username: 'Pekka', password: 'Secret1', password_confirmation: 'Secret1'

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  describe 'with too short password' do
    let(:user) { User.create username: 'Matti', password: '1Sd', password_confirmation: '1Sd' }

    it 'is not saved' do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe 'with password containing only letters' do
    let(:user) { User.create username: 'Matti', password: 'asdasd', password_confirmation: 'asdasd' }

    it 'is not saved' do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe 'favorite beer' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has method for determining one' do
      expect(user).to respond_to(:favorite_beer)
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end
end # describe User

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating user, score
  end
end

def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score: score, beer: beer, user: user)
  beer
end
