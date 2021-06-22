class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to rdirect_to login_url
    end
  end
  
  def couts(user)
    @count_posts = user.pots.count
    @count_follows = user.followings.count
    @count_followers = user.followers.count
  end
end
