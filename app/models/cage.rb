class Cage < ActiveRecord::Base

	default_scope { order(:code) }

  belongs_to :farm

  scope :fattening,  -> { where(type: "FatteningCage") }
  scope :motherhood, -> { where(type: "MotherhoodCage") }
  scope :weaning,    -> { where(type: "WeaningCage") }
  scope :race,       -> { where(type: "RaceCage") }

  validates :code, presence: true, uniqueness: { scope: :farm_id }
  validates :name,                 uniqueness: { scope: :farm_id, allow_blank: true }

  after_initialize :set_code

  attr_accessor :rabbits_size

  def rabbits_size
    self.rabbits.size
  end

  # def rabbits_size=rabbits_size
  #   return if rabbits_size.to_i != rabbits_size.to_i

  #   diff = rabbits_size.to_i - self.rabbits.size

  #   if diff < 0

  #     self.rabbits.destroy(self.rabbits.order(code: :desc).limit(diff.abs))
  #   elsif diff > 0

  #     (self.rabbits.size.(self.rabbits.size + diff)).each do |c|
  #       logger.info { "add rabbit! #{c}" }

  #       self.rabbits.new
  #     end
  #   end
  # end

  def set_code
    if farm.present? && code.nil?
      self.code = farm.cages.last.try(:code).try(:next)
    end
  end

  def title
    self.code
  end

  def list_item_heading
    if self.rabbits.any?
      "#{rabbits_size} conigli"
    else
      "Gabbia vuota"
    end
  end

  def list_item_text
    if self.rabbits.any?
      "Più vecchio: #{self.rabbits.order(:birth_date).first.age} giorni | Più giovane: #{self.rabbits.order(:birth_date).last.age}"
    else
      "Non ci sono conigli"
    end
  end

  def allowed_rabbits
  end

  def move rabbit
    wanna_be_rabbit                = rabbit.becomes(self.allowed_rabbit_class)
    wanna_be_rabbit.type           = self.allowed_rabbit_class.to_s
    wanna_be_rabbit.container_type = "Cage"
    wanna_be_rabbit.container_id   = self.id
    wanna_be_rabbit.save
  end

  def allowed_rabbit_class
    self.class.allowed_rabbit_class
  end

end
