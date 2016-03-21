class Pregnancy < ActiveRecord::Base

  default_scope { order("starting_at DESC") }

  validates :starting_at, presence: true
  validates :rabbit_id, presence: true

  validate :starting_before_ending
  validate :avoid_intersections

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

        br = BabyRabbit.new(
          pregnancy_id: self.id,
          birth_date: self.ending_at,
          container_id: self.rabbit.container_id,
          container_type: self.rabbit.container_type
        )

        self.rabbits << br

        # self.rabbits.babies.new(
        # )
      end
    end
    puts "self.rabbits => #{self.rabbits.first}"
  end

  private
    def update_rabbits_birth_date
      puts "self.ending_at_changed? => #{self.ending_at_changed?}"
      self.rabbits.update_all(birth_date: self.ending_at) if self.ending_at_changed?
    end

    def starting_before_ending
      if self.starting_at_changed? && self.starting_at > self.ending_at
        self.errors.add(:starting_at, "deve essere prima della data di conclusione")
      end
      if self.ending_at_changed? && self.starting_at > self.ending_at
        self.errors.add(:ending_at, "deve essere dopo data di inizio")
      end
    end

    def avoid_intersections
      pregnancies = self.rabbit.pregnancies.where.not(id: self.id)

      if pregnancies.where("starting_at < ? AND (ending_at > ? OR ending_at IS NULL)", self.starting_at, self.starting_at).any?
        self.errors.add(:starting_at, "non può essere durante un'altra gravidanza")
      elsif self.ending_at && pregnancies.where("starting_at < ? AND (ending_at > ? OR ending_at IS NULL)", self.ending_at, self.ending_at).any?
        self.errors.add(:ending_at, "non può essere durante un'altra gravidanza")
      end
    end

end
