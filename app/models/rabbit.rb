class Rabbit < ActiveRecord::Base

  belongs_to :container, polymorphic: true

  has_many :weights

  belongs_to :pregnancy

  validates :gender,     inclusion: { in: ["male", "female", "unknown"] }, allow_nil: true
  validates :birth_date, presence: true

  # delegate :cage, to: :compartment, prefix: true
#  delegate :value, to: :weights, prefix: true
  delegate :mother, to: :pregnancy

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

  def name_or_position
    self.name.present? ? self.name : "Coniglio in #{self.position}"
  end

  def position
    "Gabbia #{self.cage.code}"
  end

  def kill death_date = Date.today
    self.update_attributes(
      death_date: death_date || Date.today,
      container: nil
    )
  end

  def move new_cage
    self.update_attributes(container_id: new_cage.id, container_type: new_cage.type)
  end

  def mother?
    false
  end

  def baby_rabbit?
    false
  end

  def editable_fields
    [
      "container_type",
      "container_id",
      "type",
      "name",
      "birth_date",
      "gender",
      "notes"
    ]
  end
end
