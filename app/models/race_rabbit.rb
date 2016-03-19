class RaceRabbit < Rabbit
  MIN_AGE = 120

  validates :gender,     inclusion: { in: %w(male) }, allow_nil: false

  after_initialize :set_gender
  after_save :set_name_by_cage


	def self.accept_gender? gender
		gender == "male"
	end

  def editable_fields
    e_f = super
    e_f.delete("gender")
    e_f
  end

  def self.min_age
    120
  end

  private
  	def set_gender
  	  self.gender = "male"
  	end

end
