class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, {expires_in: 7.days}) { fetch_places_in(city) }
  end
  
  def self.place_where_id(id, city)
    paikat = places_in(city)
    paikat.find{|p| p.id == id}
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
		set << Place.new(place)
    end
  end

  def self.key
    "9e3fb2970b7af28244542e3626a5f19c"
  end
end