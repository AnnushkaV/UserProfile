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
    @user = User.new(user_params)
    if @user.save
      @profile = Profile.create
      @profile.user_id = @user.id
      @profile.save
      redirect_to root_url, :notice => "You have succesfully signed up!"
    else
      render "new"
    end
  end

  def edit
    puts "**********"
    @user = User.find(params[:id])
  end

  # process edit-user-form post
  def update
    puts "////////////"
    @profile = current_user.profile
    @profile.update_attributes(user_params)
    @profile.save
    if @profile.errors.empty?
      redirect_to user_path
    else
      render 'edit'
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
