class RaceRabbit < Rabbit
  MIN_AGE = 120

	def self.accept_gender? gender
		gender == "male"
	end

	
  def self.min_age
    120
  end

end
