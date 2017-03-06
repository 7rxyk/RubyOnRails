require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if many are returned by the API, all are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("testi").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Testi", id:2) ]
    )

    visit places_path
    fill_in('city', with: 'testi')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Testi"
  end
  it "if none are returned by the API, notification is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("paikkakunta").and_return(
      [  ]
    )

    visit places_path
    fill_in('city', with: 'paikkakunta')
    click_button "Search"

    expect(page).to have_content "No locations in paikkakunta"

  end
end
