class Cage < ActiveRecord::Base

  belongs_to :farm
  has_many :compartments

  # scope :fattening, 

  validates :code, presence: true, uniqueness: { scope: :farm_id }
  validates :name,                  uniqueness: { scope: :farm_id }

  def self.type_name
  	"Gabbia"
  end

  def fattening?
  	false
  end

  def self.types
  	[FatteningCage, Cage]
  end

  def compartments_count
		self.compartments.count  	
  end

end
