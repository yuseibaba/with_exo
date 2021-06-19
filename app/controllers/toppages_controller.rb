class ToppagesController < ApplicationController
  def top
    @posts = Post.order(id: :desc).page(params[:page]).per(12)
  end
  
  def about
  end
end
