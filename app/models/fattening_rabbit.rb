class FatteningRabbit < Rabbit



  def self.min_age
    70
  end

  def position
    "#{super}, cella #{self.compartment.code}"
  end


  def self.allowed_cage_type
    FatteningCage
  end

  def list_item_heading
    "miao"
  end

  def list_item_text
    "ciao"
  end

  def compartment
    self.container
  end

  def cage
    self.container.try(:cage)
  end


end
