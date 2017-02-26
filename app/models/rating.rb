class Rating < ActiveRecord::Base
  belongs_to :beer, touch: true
  belongs_to :user
  scope :recent, -> {order(created_at: :desc).limit(5)}
  #validates_uniqueness_of :beer_id, :user_id
  validates_numericality_of :score, { greater_than_or_equal_to: 1,
                                      less_than_or_equal_to: 50,
                                      only_integer: true }
  def to_s
     "#{beer.name}, #{self.score}"
  end
  def self.top_beers(n=3)
    Rating.group(:beer).order("average_score desc").limit(n).average(:score)
  end
  def self.top_raters(n=3)
    Rating.group(:user).order("count_user_id desc" ).limit(n).count("user_id")
  end
  def self.top_breweries(n=3)
    finalhash = {}
    Rating.joins(beer: :brewery).group("breweries.id").order("average_score desc").limit(n).average(:score).each do |breweryId,avg|
      newHash ={Brewery.find_by(id:breweryId) => avg}
      finalhash.merge!(newHash)
    end
    finalhash
  end
  def self.top_styles(n=3)
    finalhash = {}
    Rating.joins(beer: :style).group("styles.id").order("average_score desc").limit(3).average(:score).each do |styleID,avg|
      newHash ={Style.find_by(id:styleID) => avg}
      finalhash.merge!(newHash)
    end
      finalhash
  end
end