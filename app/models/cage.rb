class Cage < ActiveRecord::Base

  belongs_to :farm
  has_many :compartments

  has_many :rabbits, as: :container

  scope :fattening,  -> { where(type: "FatteningCage") }
  scope :motherhood, -> { where(type: "MotherhoodCage") }
  scope :weaning,    -> { where(type: "WeaningCage") }
  scope :race,       -> { where(type: "RaceCage") }

  validates :code, presence: true, uniqueness: { scope: :farm_id }
  validates :name,                 uniqueness: { scope: :farm_id, allow_blank: true }

  after_initialize :set_code

  attr_accessor :rabbits_size

  def self.types
    [FatteningCage, Cage]
  end

  def rabbits_size
    self.rabbits.size
  end

  def rabbits_size=rabbits_size
    return if rabbits_size.to_i != rabbits_size.to_i

    diff = rabbits_size.to_i - self.rabbits.size

    if diff < 0

      self.rabbits.destroy(self.rabbits.order(code: :desc).limit(diff.abs))
    elsif diff > 0

      (self.rabbits.size.(self.rabbits.size + diff)).each do |c|
        logger.info { "add rabbit! #{c}" }

        self.rabbits.new
      end
    end
  end


  def set_code
    if farm.present? && code.nil?
      self.code = farm.cages.last.try(:code).try(:next)
    end
  end



end
