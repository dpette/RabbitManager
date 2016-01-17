class Compartment < ActiveRecord::Base

	belongs_to :cage
	has_many   :compartments

end
