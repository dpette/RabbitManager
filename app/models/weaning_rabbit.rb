class WeaningRabbit < Rabbit

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

end
