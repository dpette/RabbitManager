class MotherRabbit < Rabbit

  validates :gender,     inclusion: { in: %w(female) }, allow_nil: false


  def position
    "Madre per #{self.cage.code}"
  end

end
