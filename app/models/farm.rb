class Farm < ActiveRecord::Base

  belongs_to :user
  has_many :cages

  validates :name, presence: true

  def rabbits
    rabbits_ids = []
    self.cages.each do |cage|
      rabbits_ids += cage.rabbits.pluck(:id)
    end

    Rabbit.where(id: rabbits_ids)
  end

end
