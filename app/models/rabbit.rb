class Rabbit < ActiveRecord::Base

  belongs_to :container, polymorphic: true

  has_many :weights

  belongs_to :pregnancy

  validates :gender,     inclusion: { in: ["male", "female", "unknown"] }, allow_nil: true
  validates :birth_date, presence: true
  validate  :validate_cage

  # delegate :cage, to: :compartment, prefix: true
#  delegate :value, to: :weights, prefix: true
  delegate :mother, to: :pregnancy

  after_initialize :default_values

  scope :mothers,    -> { where(type: "MotherRabbit") }
  scope :fattening,  -> { where(type: "FatteningRabbit") }
  scope :race,       -> { where(type: "RaceRabbit") }
  scope :babies,     -> { where(type: "BabyRabbit") }
  scope :weaning,    -> { where(type: "WeaningRabbit") }

  MIN_AGE = 0
  MAX_AGE = 100000

  def self.min_age
    MIN_AGE
  end

  def self.max_age
    MAX_AGE
  end

  def self.accept_gender? gender
    true
  end

  def self.accept_age? age
    logger.info "age > #{self.min_age} && age < #{self.max_age}"
    age > self.min_age && age < self.max_age
  end

  def can_become_classes
    c_b_c = []

    [MotherRabbit, FatteningRabbit, RaceRabbit, BabyRabbit, WeaningRabbit].each do |rabbit_class|
      puts "go fo #{rabbit_class}"
      if rabbit_class.accept_age?(self.age) && rabbit_class.accept_gender?(self.gender)
        puts "YESS!"
        c_b_c << rabbit_class
      end
    end

    c_b_c
  end

  def age
    birth_date ? (Date.today - birth_date).to_i : 0
  end

  def last_weight
    weights.first.try(:value)
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
    "#{self.cage.code}"
  end

  def kill death_date = Date.today
    self.update_attributes(
      death_date: death_date || Date.today,
      container_id: nil,
      container_type: nil
    )
  end

  def move new_cage, new_compartment
    self.update_attributes(container_id: new_cage.id, container_type: new_cage.type, type: "WeaningRabbit")
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

  def list_item_heading
    name
  end

  def list_item_text
    if self.last_weight.nil?
      "Nessun peso registrato"
    else
      "#{last_weight} Kg #{self.weights.last.days_from_registration} giorni fa"
    end
  end

  def secondary_infos
    infos = {}

    if self.last_weight.present?
      infos[:weight] = "#{self.last_weight} Kg"
    else
      infos[:weight] = "Nessun peso"
    end

    infos
  end

  protected
    def set_name_by_cage
      if self.name_changed? && self.cage.name != self.name
        self.cage.update_attributes(name: self.name)
      end

      if self.container_id_changed? && self.container_id && self.cage.name != self.name
        self.update_attributes(name: self.cage.name)
      end
    end

    def validate_cage
      puts "self.class #{self.class}"
      if cage && !cage.kind_of?(self.class.allowed_cage_type)
        self.errors.add(:cage, "deve essere una #{self.class.allowed_cage_type.model_name.human}")
      end
    end


end
