class SessionsController < ApplicationController

  def splashpage
    render layout: false 
  end

  def new
  end

  def create
    @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])

    return render action: 'new' unless @user

    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
