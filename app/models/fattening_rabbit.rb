class FatteningRabbit < Rabbit

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


end
