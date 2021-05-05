class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    # if user is nil, it won't call authenticate which would cause an error.
    # if user && user.authenticate(params[:password]) // Same as below.
    if user&.authenticate(params[:password])
      # put user id in session
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = 'Invalid email/password combination!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to events_url, notice: "You're now signed out!"
  end
end
