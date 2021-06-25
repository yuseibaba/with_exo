class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:favorite_id])
    current_user.like(post)
    flash[:notice] = 'お気に入りしました。'
    redirect_to post
  end

  def destroy
    post = Post.find(params[:favorite_id])
    current_user.unlike(post)
    flash[:notice] = 'お気に入りを解除しました。'
    redirect_to post
  end
  
end
