class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update destroy]
  before_action :set_user!, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User was successfully updated."
      redirect_to edit_user_path(@user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
    end
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome! You have signed up successfully #{current_user.name_or_email}."
      redirect_to root_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @user = User.find(params[:id])
  end

  def destroy
    # @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User was successfully deleted."
    redirect_to root_path
  end

  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :old_password)
  end
end
