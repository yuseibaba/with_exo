class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
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
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :species, :post_image)
  end
  
end
