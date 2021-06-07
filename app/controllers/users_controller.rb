class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = '登録が完了しました。'
      redirect_to root_path
    else
      flash.now[:notice] = '登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end

