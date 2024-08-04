module SessionsHelper
  def login user
    session[:user_id] = user.id
    # Guard against session replay attacks.
    # See https://bit.ly/33UvK0w for more.
    session[:session_token] = user.session_token
  end

  def current_user
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif user_id = cookies.encrypted[:user_id]
      # FIXME
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies.encrypted[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    forget @current_user
    reset_session
    @current_user = nil
  end

  def remember user
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent.encrypted[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
