class MotherhoodCage < Cage
  has_many :rabbits, as: :container

  def mother
    self.rabbits.mothers.first
  end

  def rabbits_size
    self.rabbits.babies.size
  end

  # def rabbits_size=rabbits_size
  #   return if rabbits_size.to_i != rabbits_size.to_i

  #   diff = rabbits_size.to_i - self.rabbits.babies.size

  #   if diff < 0

  #     self.rabbits.destroy(self.rabbits.babies.limit(diff.abs))
  #   elsif diff > 0

  #     ((self.rabbits.babies.size + 1)..(self.rabbits.babies.size + diff)).each do |r|
  #       logger.info { "add baby rabbit! #{r}" }

  #       self.rabbits.babies.new(mother_id: self.mother.id)
  #     end
  #   end
  # end


  def list_item_heading
    if self.mother && self.mother.name.present?
      self.mother.name
    elsif self.mother.nil?
      self.name || "Senza madre"
    else
      super
    end
  end

  def list_item_text
    if self.rabbits_size > 0
      "#{self.rabbits_size} cuccioli da #{self.rabbits.last.age} giorni"
    elsif self.mother.nil?
      ""
    elsif self.mother.pregnant?
      "Incinta da #{self.mother.in_progress_pregnancy.days_from_start} giorni"
    else
      "0 cuccioli"
    end
  end

  def self.allowed_rabbit_class
    BabyRabbit
  end


end
