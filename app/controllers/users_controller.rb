class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @pagy, @users = pagy(User.all)
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully"
      redirect_to @user
    else
      flash.now[:danger] = "Create user failed"
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
