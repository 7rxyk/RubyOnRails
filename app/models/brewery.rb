class Beer < ActiveRecord::Base
  belongs_to :brewery
end

class Brewery < ActiveRecord::Base
  has_many :beers
end