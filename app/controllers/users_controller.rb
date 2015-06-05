class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
   @users = User.all
  end
  def new
   @user = User.new
  end

  def create
    #User.create(user_params)
    if @user.save
      flash[:success] = "User added and activated."
      redirect_to users_path
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, profile_attributes: [:name, :avatar])
  end
end
