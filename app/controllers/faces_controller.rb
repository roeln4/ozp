class FacesController < ApplicationController

	# @author Roel Noordmans <r.h.noordmans@students.uu.nl>

	before_action :logged_in_user, except: [:consent, :index, :step1]

	before_action :has_completed_training, only: [:questionnaire, :save_questionnaire]

	def consent

		# If known user, let's redirect them to the first step. They have no business being here.

		if session[:has_completed]

	    	flash[:danger] = "Je hebt al deelgenomen aan dit onderzoek. Gelieve het slechts een enkele keer te proberen."

	    end


		if @current_user

			redirect_to create_path

		end

	end

	def index

		# If known user, let's redirect them to the first step. They have no business being here.

		if @current_user

			redirect_to create_path

		end

	end

	def step1

		if session[:has_completed]

	    	flash[:danger] = "Je hebt al deelgenomen aan dit onderzoek. Gelieve het slechts een enkele keer te proberen."

	    	redirect_to landing_path and return

	    end

		if @current_user

			Answer.where(participant: @current_user).where.not(is_locked: true).destroy_all

			log_out

		end

		participant = Participant.create!

		participant.music_enabled = [true, false].sample

		# Generate the order in which the participant will see the faces and their names

		participant.progress = Face.all.shuffle

		participant.save!

		log_in participant

		redirect_to begin_path

	end

	def step2

		# Let's show them the faces in their progress. If the progress is empty, it means that
		# they have seen all the faces and we can redirect them to step 3.

		@faces = @current_user.progress

		@participant = @current_user		

	end

	def lock_answers

		# If the participant has seen all the faces, we want to lock their answers
		# so that we know we need to redirect them to the questionnaire

		Answer.where(participant_id: @current_user.id).update_all(is_locked: true)
		@current_user.has_completed_training = true
		@current_user.save!

		# All set!

	end

	def gather_user_information

		# This is the page where they are given a video to wipe their short-term memory
		# and where we are also asking them about some personal information

		# Let's first check if they belong here - that is, if their answers are locked. We
		# can check that by simply checking the first answer.

		if not @current_user.has_completed_training

			# Not sure how they ended up here but they do not belong here.

			redirect_to create_path

		end

		@participant = @current_user
		

	end

	def process_user_information

		if params[:participant]

			if params[:participant][:age] && params[:participant][:current_study] && params[:participant][:gender]

				@participant = @current_user.update(participant_params)

				redirect_to questionnaire_path
			end
		end

	end

	def questionnaire

		# Generating a random int to make sure participant cannot cheat
		# in the HTML source code by comparing face_id with answer_id by
		# incrementing the face_id with this random number and later
		# subtracting it

		@random_addition_face_id = rand(1...10000)

		# Save to the session so we can substract it later

		session[:random_addition_face_id] = @random_addition_face_id

		@participant = @current_user

		@faces_random_order = @participant.progress.shuffle

		# Making sure the participant sees a different order of faces
		# (even though the odds of that happening are 1/12! (479.001.600))

		while @faces_random_order == @participant.progress
			@faces_random_order = @participant.progress.shuffle 
		end

		@participant.questionnaire_progress = @faces_random_order

		@participant.save!

		@faces = Face.all

	end

	def process_questionnaire

		answers_correct = 0

		for face_id, answer in params[:answer]

			face = Face.find_by(id: face_id.to_i - session[:random_addition_face_id].to_i)

			if face.id.to_i == answer.to_i
				correct = true
				answers_correct += 1
			else
				correct = false
			end

			Answer.create(participant_id: @current_user.id, face_id: face.id, correct: correct)

		end

		session[:answers_correct] = answers_correct

		redirect_to final_questions_path

	end

	def final_questions

		# Let's check if they have answered all the questions before entering here

		if not Answer.where(participant_id: @current_user.id).count > 0
			redirect_to questionnaire_path
		end

	end

	def process_final_questions

		if params.include?(:participant)

			if params[:participant][:has_heard_music] == "Ja"
				params[:participant][:has_heard_music] = true
			else
				params[:participant][:has_heard_music] = false
			end

			participant = @current_user

			participant.update(participant_params)

			participant.save!

			session[:has_completed] = true

			redirect_to end_questionnaire_path

		end

	end

	def roelproberenlol



	end	

	def end_questionnaire

	end

	private

	def participant_params
		params.require(:participant).permit(:current_study, :gender, :age, :has_heard_music, :comment, :feeling, :rating)
	end

	def questionnaire_params
		params.require(:answer).permit(:face_id)
	end

end
