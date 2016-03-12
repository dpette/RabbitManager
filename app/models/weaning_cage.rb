class WeaningCage < Cage
  has_many :rabbits, as: :container
end
