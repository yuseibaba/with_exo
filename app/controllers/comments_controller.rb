class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if  @comment.save
      flash[:notice] = 'コメントしました。'
      redirect_to @post
    else
      @post = Post.find(params[:post_id])
      counts(@post)
      flash[:notice] = 'コメントに失敗しました。'
      render template: "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    comment.destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_to @post
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
