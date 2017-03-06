require 'rails_helper'

RSpec.describe Beer, type: :model do
  it 'is saved with name and style' do
    beer = Beer.new name: 'Test', style: 'Weizen'
    beer.save
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it 'is not saved without name' do
    beer = Beer.new style: 'Weizen'
    beer.save
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it 'is not saved without style' do
    beer = Beer.new name: 'Weizen'
    beer.save
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
