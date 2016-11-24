class SessionsController < ApplicationController

  def new
  end

  def create
    # we search the database for a user with email address in the params hash.
    user = User.find_by(email: params[:session][:email].downcase)

    # verify that user is not nil and the password in the params has matches the specified password.  If the user is succesfully authenticated, we call create_session function, display a flash notice and redirect the user to root_path.
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      #if authentication is not successful, flash a warning message and render new view.
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    # this will delete a user's session.  
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end

end
