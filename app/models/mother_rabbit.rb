class MotherRabbit < Rabbit

  validates :gender,     inclusion: { in: %w(female) }, allow_nil: false

  has_many :pregnancies, :class_name => "Pregnancy", :foreign_key => "rabbit_id"#, dependent: :destroy

  after_initialize :set_gender

  MIN_AGE = 120


  def position
    "Madre per #{self.cage.code}"
  end

  def mother?
    true
  end

  def in_progress_pregnancy
    self.pregnancies.in_progress.first
  end

  def pregnant?
    self.in_progress_pregnancy.present?
  end

  def editable_fields
    e_f = super
    e_f.delete("gender")
    e_f
  end

  def list_item_heading
    self.name.present? ? self.name : "Madre per gabbia #{self.cage.code}"
  end


  def secondary_infos
    infos = super

    puts infos

    if self.pregnant?
      infos[:pregnancy] = "Incinta da #{self.in_progress_pregnancy.days_from_start} giorni"
    else
      infos[:pregnancy] = "#{self.pregnancies.completed.size} parti"
    end

    infos
  end

  def self.allowed_cage_type
    MotherhoodCage
  end


  def self.accept_gender? gender
    gender == "female"
  end

  def self.min_age
    120
  end


  private
    def set_gender
      self.gender = "female"
    end


end
