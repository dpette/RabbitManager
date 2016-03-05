class Pregnancy < ActiveRecord::Base

  default_scope { order("starting_at DESC") }

  validates :starting_at, presence: true
  validates :rabbit_id, presence: true

  belongs_to :rabbit
  has_many :rabbits, dependent: :destroy

  scope :completed,   -> { where.not(ending_at: nil) }
  scope :in_progress, -> { where(ending_at: nil) }

  after_save :update_rabbits_birth_date

  def editable_fields
    ["starting_at", "ending_at", "rabbit_id", "rabbits_size"]
  end

  def in_progress?
    ending_at.nil?
  end

  def days_from_start
    (Date.today - starting_at).to_i
  end

  def mother
    self.rabbit
  end

  def rabbits_size
    self.rabbits.size
  end

  def rabbits_size=rabbits_size
    # return if rabbits_size.to_i != rabbits_size.to_i

    diff = rabbits_size.to_i - self.rabbits.size

    if diff < 0

      self.rabbits.destroy(self.rabbits.limit(diff.abs))
    elsif diff > 0

      ((self.rabbits.size + 1)..(self.rabbits.size + diff)).each do |r|
        logger.info { "add baby rabbit! #{r}" }

        self.rabbits.babies.new(
          pregnancy_id: self.id,
          birth_date: self.ending_at,
          container_id: self.rabbit.container_id,
          container_type: self.rabbit.container_type
        )
      end
    end
  end

  private
    def update_rabbits_birth_date
      puts "self.ending_at_changed? => #{self.ending_at_changed?}"
      self.rabbits.update_all(birth_date: self.ending_at) if self.ending_at_changed?
    end


end
