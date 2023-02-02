module SessionHelper
  def log_in(participant)
    session[:participant_id] = participant.id
  end

  def current_user
    if session[:participant_id]
      @current_user ||= Participant.find_by(id: session[:participant_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:participant_id)
    @current_user = nil
  end

  def current_user?(participant)
    participant == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end