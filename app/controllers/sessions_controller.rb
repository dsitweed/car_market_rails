class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params.dig(:session, :email))
    if user&.authenticate(params.dig(:session, :password))
      login user
      flash[:success] = "Login successful!"
      redirect_to user
    else
      flash.now[:danger] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
