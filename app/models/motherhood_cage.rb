class MotherhoodCage < Cage

  def mother
    self.rabbits.mothers.first
  end

  def rabbits_size
    self.rabbits.babies.size
  end

  def rabbits_size=rabbits_size
    return if rabbits_size.to_i != rabbits_size.to_i

    diff = rabbits_size.to_i - self.rabbits.babies.size

    if diff < 0

      self.rabbits.destroy(self.rabbits.babies.limit(diff.abs))
    elsif diff > 0

      ((self.rabbits.babies.size + 1)..(self.rabbits.babies.size + diff)).each do |r|
        logger.info { "add baby rabbit! #{r}" }

        self.rabbits.babies.new(mother_id: self.mother.id)
      end
    end
  end


  def title
    if self.mother.name.present?
      self.mother.name
    else
      super
    end
  end

end
