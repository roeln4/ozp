class ApplicationController < ActionController::Base

	include SessionHelper

	private
	def logged_in_user
	  unless logged_in?
	    store_location
	    flash[:danger] = "Je bent op een onverwachte plek gekomen in dit onderzoek. Je wordt doorgestuurd naar de beginpagina."
	    redirect_to login_url
	  end
	end

	def has_completed_training
		unless logged_in? && @current_user.has_completed_training? && @current_user.age
			store_location
			flash[:danger] = "Je moet eerst de gezichten gezien hebben voordat je kan gaan koppelen"
			redirect_to begin_path
		end
	end

end
