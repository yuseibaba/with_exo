class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy, :followings, :followers]

  def index
    if params[:search]
      @users = User.where('name LIKE(?)', "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @users = User.order(id: :desc).page(params[:page]).per(8)
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = '登録が完了しました。'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:notice] = '登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = '編集が完了しました。'
      redirect_to @user
    else
      flash.now[:notice] = '編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = '退会しました。'
    redirect_to root_url
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(8)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(8)
  end

  def likes
    @user = User.find(params[:id])
    @posts = @user.likes.page(params[:page]).per(8)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce_comment, :image)
  end
end
