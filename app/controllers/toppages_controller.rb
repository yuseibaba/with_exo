class ToppagesController < ApplicationController
  def top
    @posts = Post.order(id: :desc).page(params[:page]).per(12)
    if logged_in?
      @feed_posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(12)
    end
  end

  def about; end
end
