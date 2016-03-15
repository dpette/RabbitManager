class BabyRabbit < Rabbit
  validate :validate_cage

  MIN_AGE = 0
  MAX_AGE = 35

  def baby_rabbit?
    true
  end

  # def can_become_classes
  #   c_b_c = super
  # end

  def self.allowed_cage_type
    MotherhoodCage
  end


  def self.min_age
    0
  end

  def self.max_age
    35
  end

  private
    def validate_cage
      if !cage.kind_of? MotherhoodCage
        self.errors.add(:cage, "deve essere una gabbia fattrice")
      end
    end

end
