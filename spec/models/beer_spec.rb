require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is saved with name and style set" do
    beer = Beer.create name: "TestBeer", style: "TestStyle"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name set" do
    beer = Beer.create style: "TestStyle"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style set" do
    beer = Beer.create name: "TestBeer"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end