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

  def list_item_text
    if self.last_weight.nil?
      "Nessun peso registrato"
    else
      "#{last_weight} Kg #{self.weights.last.days_from_registration} giorni fa"
    end
  end

  def compartment
    self.container
  end

  def cage
    self.container.try(:cage)
  end


end
