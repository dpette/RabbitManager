class RaceCage < Cage

  validate :only_one_rabbit


  has_many :rabbits, as: :container

  private
    def only_one_rabbit
      if self.rabbits.size > 1
        self.errors.add(:base, "Questa gabbia può avere solo un coniglio")
      end
    end
end
