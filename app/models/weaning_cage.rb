class WeaningCage < Cage
  has_many :rabbits, as: :container


  def self.allowed_rabbit_class
    WeaningRabbit
  end


end
