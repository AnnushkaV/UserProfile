class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profile = @user.profile
    @profile = Profile.find(params[:id])  # ничего не менять!
  end

  def new
    @user = User.new
    @user = current_user
    @profile = Profile.new
  end

  def create
    @user = User.find(current_user.id)
    @profile = Profile.find_by_user_id(@user)
   # @profile.user_id = current_user.id
    if @profile = @user.create_profile(profile_params)
      flash[:success] = "Account created"
      redirect_to user_profile_path(@user, @profile)
    else
      render 'new'
    end
  end

  def edit
   @user = current_user
   @profile = @user.profile
   @profile = Profile.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @profile = Profile.find(@user.profile)
    #@profile.id = @user.id
    @profile.update_attributes(profile_params)
    if @profile.errors.empty?
     redirect_to user_profile_path(@user, @profile)
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:avatar)
  end
end
