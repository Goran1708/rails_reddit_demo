class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_subreddits
  before_action :authenticate_user!
  layout :layout
   
  def set_subreddits
    @subreddits = Subreddit.all
  end

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : "application"
    # or turn layout off for every devise controller:
    #devise_controller? && "application"
  end

end
