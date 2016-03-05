class BabyRabbit < Rabbit
  validate :validate_cage

  def baby_rabbit?
    true
  end

  private
    def validate_cage
      if !cage.kind_of? MotherhoodCage
        self.errors.add(:cage, "deve essere una gabbia fattrice")
      end
    end

end
