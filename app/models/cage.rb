class Cage < ActiveRecord::Base

  belongs_to :farm
  has_many :compartments

  validates :code, presence: true, uniqueness: { scope: :farm_id }
  validates :name,                  uniqueness: { scope: :farm_id }



end
