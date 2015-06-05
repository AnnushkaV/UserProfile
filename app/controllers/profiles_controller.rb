class ProfilesController < ApplicationController
  def show
    @user = current_user
     @profile = @user.profile
  end

  def new
    @user = current_user
    @profile = Profile.new
  end

  def create
    @user = current_user
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:success] = "Account created"
      redirect_to profile_path
    else
      render 'new'
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    @profile.assign_attributes(profile_params)
    if profile.save
      redirect_to [current_user, profile]
    else
      render :new
    end
  end

  private
  def profile_params
    params.require(:profiles).permit(:name, :avatar)
  end
end
