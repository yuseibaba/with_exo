class ToppagesController < ApplicationController
  def top
    @posts = Post.order(id: :desc).page(params[:page]).per(8)
    if logged_in?
      @feed_posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(8)
    end
  end

  def about; end
end
