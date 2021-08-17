class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def index
    if params[:search]
      @posts = Post.where(['content LIKE(?) OR species LIKE(?)', "%#{params[:search]}%", "%#{params[:search]}%"])
    else
      @posts = Post.order(id: :desc).page(params[:page]).per(12)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments.order(id: :desc)
    counts(@post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = '投稿しました。'
      redirect_to posts_url
    else
      flash[:notice] = '投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :species, :post_image, :search)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
