class RaceCage < Cage
  has_many :rabbits, as: :container
end
