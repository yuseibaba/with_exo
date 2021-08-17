class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
      flash[:notice] = 'ログインしてください。'
    end
  end

  def counts(post)
    @count_likes = post.liked.count
    @count_comments = post.comments.count
  end
end
