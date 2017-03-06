module RatingAverage
  extend ActiveSupport::Concern
	def average_rating
		avg = 0
		self.ratings.each do |rating|
			avg += rating.score
		end
		b = (avg.to_d / self.ratings.count)
		((b*10).round / 10.0)
	end
end