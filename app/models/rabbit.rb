class Rabbit < ActiveRecord::Base

  belongs_to :container, polymorphic: true

  has_many :weights

  validates :gender,     inclusion: { in: %w(male female) }, allow_nil: true
  validates :birth_date, presence: true

  delegate :cage, to: :compartment, prefix: true
#  delegate :value, to: :weights, prefix: true

  after_initialize :default_values

  scope :mothers,    -> { where(type: "MotherRabbit") }
  scope :fattening,  -> { where(type: "FatteningRabbit") }
  scope :race,       -> { where(type: "RaceRabbit") }
  scope :babies,     -> { where(type: "BabyRabbit") }
  scope :weaning,    -> { where(type: "WeaningRabbit") }


  def age
    birth_date ? (Date.today - birth_date).to_i : 0
  end

  def last_weight
    weights.last.try(:value)
  end

  def cage
    if self.container.kind_of? Cage
      self.container
    elsif self.container.kind_of? Compartment
      self.container.cage
    end
  end

  def default_values
    self.birth_date ||= Date.today
  end

end
