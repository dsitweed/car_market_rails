class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params.dig(:session, :email))

    if user&.authenticate(params.dig(:session, :password))
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
        login user
        flash[:success] = "Login successful!"
        redirect_to forwarding_url || user
      else
        message = "Account not activated. "
        message << "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url, status: :see_other
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
