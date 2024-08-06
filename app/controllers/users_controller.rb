class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:show, :create, :new]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.all.desc)
  end

  def show
    redirect_to root_url and return unless @user.activated?
    @user.send_activation_email_sidekiq
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email_sidekiq
      message = "User created successfully. "
      message += "Please check your email to activation your account."
      flash[:info] = message
      redirect_to root_url
    else
      flash.now[:danger] = "Create user failed"
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated succesfully!"
      redirect_to @user
    else
      flash[:danger] = "Update user failed"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted successfully"
      redirect_to users_path, status: :see_other
    else
      flash[:danger] = "Delete user failed"
      redirect_to users_path, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filter

  # Confirms a logged in user
  def logged_in_user
    return if logged_in?

    store_location
    flash[:warning] = "Please log in."
    redirect_to login_url, status: :see_other
  end

  # Confirms the currect user
  def correct_user
    redirect_to root_url, status: :see_other unless current_user == @user
  end

  # Confirms an admin user
  def admin_user
    redirect_to root_url, status: :see_other unless current_user.is_admin?
  end
end
