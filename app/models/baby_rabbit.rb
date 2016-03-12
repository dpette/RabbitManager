class BabyRabbit < Rabbit
  validate :validate_cage

  def baby_rabbit?
    true
  end

  def can_become_classes
    [WeaningRabbit, BabyRabbit]
  end

  def allowed_cage_types
    [MotherhoodCage]
  end


  def move cage, compartment = nil
    wanna_be = self.becomes(WeaningRabbit)
    wanna_be.type = "WeaningRabbit"
    wanna_be.container_type = "Cage"
    wanna_be.container_id   = cage.id
    wanna_be.save
  end


  private
    def validate_cage
      if !cage.kind_of? MotherhoodCage
        self.errors.add(:cage, "deve essere una gabbia fattrice")
      end
    end

end
