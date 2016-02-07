class Farm < ActiveRecord::Base

  belongs_to :user
  has_many :cages

  validates :name, presence: true

end
