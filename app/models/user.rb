class User < ActiveRecord::Base

  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 30}

  validates :password, length: {minimum: 4}

  validates_format_of :password, :with => /\A(?=.*[A-Z])(?=.*\d).+\z/

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    return ratings.sort_by(&:score).last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    return Beer.find_by_sql("SELECT beers.*, SUM(ratings.score) as sum FROM beers JOIN ratings ON beers.id = ratings.beer_id JOIN users ON ratings.user_id = users.id WHERE ratings.user_id = " + id.to_s + " GROUP BY beers.style ORDER BY sum DESC LIMIT 1").first.style
  end

  def favourite_brewery
     return nil if ratings.empty?
     return Beer.find_by_sql("SELECT beers.*, SUM(ratings.score) as sum FROM beers JOIN ratings ON beers.id = ratings.beer_id JOIN users ON ratings.user_id = users.id JOIN breweries ON breweries.id = beers.brewery_id WHERE ratings.user_id = " + id.to_s + " GROUP BY breweries.id ORDER BY sum DESC LIMIT 1").first.brewery.name
  end
end