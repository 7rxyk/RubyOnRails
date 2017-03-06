require 'rails_helper'
include Helpers

describe 'Beer' do
  before :each do
    FactoryGirl.create :brewery
    FactoryGirl.create :user
    visit signin_path
    fill_in('username', with: 'Pekka')
    fill_in('password', with: 'Foobar1')
    click_button('Log in')
  end

  it 'with a name is added to db' do
    visit new_beer_path
    fill_in('beer_name', with: 'Kalia')

    expect do
      click_button('Create Beer')
    end.to change { Beer.count }.by(1)
  end

  it 'without a name is not added to db' do
    visit new_beer_path

    expect do
      click_button('Create Beer')
    end.not_to change{ Beer.count }
    expect(page).to have_content 'Name can\'t be blank'
  end
end
