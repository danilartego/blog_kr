class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome! You have signed up successfully #{@user.name}."
      redirect_to root_path, notice: "User was successfully created."
    else
      render :new, alert: "Failed to create user."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out successfully."
    redirect_to root_path, notice: "User was successfully destroyed."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
