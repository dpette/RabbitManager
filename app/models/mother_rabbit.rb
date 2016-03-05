class MotherRabbit < Rabbit

  validates :gender,     inclusion: { in: %w(female) }, allow_nil: false

  has_many :pregnancies, :class_name => "Pregnancy", :foreign_key => "rabbit_id", dependent: :destroy

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


end
