class RaceCage < Cage

  validate :only_one_rabbit

  has_many :rabbits, as: :container

  def rabbit
  	self.rabbits.first
  end

  def list_item_text
    if self.rabbit
    	self.rabbit.list_item_text
    else
      ""
    end
  end

  def list_item_heading
    if self.rabbit
    	self.rabbit.list_item_heading
    else
      "Vuota"
    end
  end


  private
    def only_one_rabbit
      if self.rabbits.size > 1
        self.errors.add(:base, "Questa gabbia può avere solo un coniglio")
      end
    end
end
