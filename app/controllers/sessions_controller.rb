class SessionsController < ApplicationController
  def new; end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:notice] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash[:notice] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました。'
    redirect_to root_url
  end

  def guest_login
    user = User.guest
    session[:user_id] = user.id
    flash[:notice] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      true
    else
      false
    end
  end
end
