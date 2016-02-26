class FatteningRabbit < Rabbit

  def position
    "#{super}, cella #{self.compartment.code}"
  end

end
