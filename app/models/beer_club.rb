class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user
  has_many :membership_confirmations, dependent: :destroy

  def to_s
    name.to_s
  end
end
