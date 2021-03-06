class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new 
    render :new 
  end 

  def show 
    redirect_to new_session_url
  end 

  def create 
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user 
      log_in_user!(@user)
      redirect_to user_url(@user)
    else 
      flash.now[:errors] = ["INVALID CREDENTIALS"]
      render :new 
    end 
  end 

  def destroy 
    logout
    redirect_to new_session_url 
  end 
end
