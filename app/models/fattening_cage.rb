class FatteningCage < Cage

	has_many :compartments, foreign_key: :cage_id
  accepts_nested_attributes_for :compartments, allow_destroy: true

  attr_accessor :compartments_size

  def compartments_size
    self.compartments.size
  end

  def compartments_size=compartments_size
    return if compartments_size.to_i != compartments_size.to_i

    diff = compartments_size.to_i - compartments.size

    if diff < 0
      compartments.destroy(compartments.order(code: :desc).limit(diff.abs))
    elsif diff > 0

      ((compartments.size + 1)..(compartments.size + diff)).each do |c|
        logger.info { "add compartment! #{c}" }

        self.compartments.new
      end
    end
  end

  def list_item_heading
    "#{self.compartments_size} celle, #{self.compartments.busy.size} occupate"
  end

  def list_item_text
    heavier_rabbit = self.rabbits.includes(:weights).sort { |a, b| b.last_weight <=> a.last_weight  }.first
    if heavier_rabbit
      "Più pesante #{heavier_rabbit.last_weight} Kg"
    else
      ""
    end
  end

  def rabbits
    FatteningRabbit.where(container_id: self.compartments.pluck(:id))
  end


end
