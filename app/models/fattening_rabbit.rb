class FatteningRabbit < Rabbit



  def self.min_age
    70
  end

  def position
    "#{super} #{self.compartment.code}"
  end


  def self.allowed_cage_type
    FatteningCage
  end

  def list_item_heading
    "#{age} giorni"
  end

  def compartment
    self.container
  end

  def cage
    self.container.try(:cage)
  end


end
