class Weight < ActiveRecord::Base
  default_scope { order(registered_on: :desc) }

  belongs_to :rabbit

  validates :value,     presence: true, numericality: { greater_than: 0 }
  validates :registered_on, uniqueness: { scope: :rabbit_id, message: "Peso già registrato in questa data" }

  def days_from_registration
    (Date.today - registered_on).to_i
  end


end
