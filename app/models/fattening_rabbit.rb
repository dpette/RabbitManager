class FatteningRabbit < Rabbit

  def position
    "#{super}, cella #{self.compartment.code}"
  end


  def self.allowed_cage_type
    FatteningCage
  end

end
