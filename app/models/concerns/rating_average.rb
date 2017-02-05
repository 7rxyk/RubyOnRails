module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    return 0 if self.ratings.size == 0
    self.ratings.map { |r| r.score }.inject(:+) / self.ratings.size
  end
end