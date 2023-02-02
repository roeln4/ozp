class Participant < ApplicationRecord

	has_many :answers, dependent: :destroy

	# We do not want to lose participants if a delete command misbehaves, so we enable soft delete
	
	acts_as_paranoid


	def has_locked_answers?
		Answer.where(participant: @current_user, is_locked: true).count > 0
	end

end
