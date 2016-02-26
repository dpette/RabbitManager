class Weight < ActiveRecord::Base

  belongs_to :rabbit

  validates :value,     presence: true, numericality: { greater_than: 0 }
  validates :registered_on, uniqueness: { scope: :rabbit_id, message: "Peso già registrato in questa data" }


end
