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

        self.compartments.new
      end
    end
  end

  def list_item_heading
    "#{self.compartments.size} celle"
  end

  def list_item_text
    "#{self.compartments.empty.size} celle libere"
  end


end
