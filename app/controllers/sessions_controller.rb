# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: [:destroy]

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in user
      remember user if params[:remember_me] == '1' # remember user if they check the box
      flash[:success] = "Welcome to the app, #{current_user.name}"
      redirect_to root_path
    else
      flash[:warning] = 'incorrect email and/or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    flash[:success] = 'See you later!'

    redirect_to root_path
  end
end
