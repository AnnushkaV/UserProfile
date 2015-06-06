class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
   @users = User.all
   @users = User.paginate(page: params[:page])
  end
  def new
   @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "User added and activated."
      redirect_to users_path
    else
      render 'new'
    end
  end

  def sender
    @user = User.find(params[:id])
  end

  def reciver
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_me, profile_attributes: [ :avatar])
  end
end
