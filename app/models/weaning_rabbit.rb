class WeaningRabbit < Rabbit

  MIN_AGE = 25
  MAX_AGE = 100

  def self.min_age
    MIN_AGE
  end

  def self.min_age
    MAX_AGE
  end

  def self.allowed_cage_type
    WeaningCage
  end

  def can_become_classes
    c_b_c = [WeaningRabbit]
    c_b_c << BabyRabbit      if self.age < 50
    c_b_c << FatteningRabbit if self.age > 30
    c_b_c << MotherRabbit    if self.gender == "female" && age > 50

    c_b_c
  end


  def self.min_age
    25
  end

  def self.max_age
    100
  end


end
