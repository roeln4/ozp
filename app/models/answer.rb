class Answer < ApplicationRecord

	# We do not want to lose answers if a delete command misbehaves, so we enable soft delete

	acts_as_paranoid


end
