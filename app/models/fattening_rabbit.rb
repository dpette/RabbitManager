class FatteningRabbit < Rabbit

  def position
    "#{super}, cella #{self.compartment.code}"
  end


  def allowed_cage_types
    [FatteningCage]
  end

end
