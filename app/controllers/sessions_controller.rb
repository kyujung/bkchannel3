class SessionsController < ApplicationController

  def create
    if user = User.authenticate(params[:email], params[:password])
       session[:user_nickname] = user.nickname
       redirect_to messages_path, :notice => "Logged in successfully"
    else
       flash.now[:alert] = "Invalid login/password combination"
       render :action => 'new'
    end
  end

  def destroy
    @seat2 = Seat.where(:nickname => session[:user_nickname]).first
    if @seat2
       @seat2.update_attributes(:nickname => 'empty')
     end
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end
end
