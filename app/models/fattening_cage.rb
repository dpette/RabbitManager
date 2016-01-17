class FatteningCage < Cage

	has_many :comparments

	def self.type_name
		"Ingrasso"
	end

	def fattening?
		true
	end

end
