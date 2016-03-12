class WeaningRabbit < Rabbit

  def allowed_cage_types
    [WeaningCage]
  end

  def can_become_classes
    c_b_c = [WeaningRabbit]
    c_b_c << BabyRabbit      if self.age < 50
    c_b_c << FatteningRabbit if self.age > 30

    c_b_c
  end

  def move cage, compartment = nil
    wanna_be = self.becomes(WeaningRabbit)
    wanna_be.type = "WeaningRabbit"
    wanna_be.container_type = "Cage"
    wanna_be.container_id   = cage.id
    wanna_be.save
  end

  def move cage, compartment = nil
  end

end
