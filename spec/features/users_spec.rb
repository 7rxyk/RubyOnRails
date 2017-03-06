require 'rails_helper'
include Helpers

describe 'User' do
  before :each do
    FactoryGirl.create :user
  end

  describe 'who has signed up' do
    it 'can signin with right credentials' do
      visit signin_path
      fill_in('username', with: 'Pekka')
      fill_in('password', with: 'Foobar1')
      click_button('Log in')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it 'is redirected back to signin form if wrong credentials given' do
      visit signin_path
      fill_in('username', with: 'Pekka')
      fill_in('password', with: 'wrong')
      click_button('Log in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it 'when signed up with good credentials, is added to the system' do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')

      expect do
        click_button('Create User')
      end.to change { User.count }.by(1)
    end

    it 'when signed in can view own ratings' do
      user = FactoryGirl.create :user, username: 'Pekka2'
      FactoryGirl.create :beer
      FactoryGirl.create :brewery
      FactoryGirl.create :rating, user_id: 1, beer_id: 1
      FactoryGirl.create :rating, user_id: 2, beer_id: 1
      visit user_path(user)
      expect(page).to have_content 'Has made 1 rating'
    end

  end
end
