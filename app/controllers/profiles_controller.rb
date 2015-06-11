class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @user = current_user
    @profile = Profile.new
  end

  def create
    @user = User.find(current_user.id)
    @profile = Profile.find(@user.profile)
    #@profile.id = @user.id
    @profile.update_attributes(profile_params)
    if @profile.errors.empty?
      redirect_to profile_path
    else
      render 'new'
    end
  end

  def edit
   @user = current_user
   @profile = Profile.find(params[:id])
  end

  def update
    puts "________________________"
    puts profile_params
    @profile = current_user.profile
    @profile.update_attributes(profile_params)
    @profile.save
    if @profile.errors.empty?
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:avatar, user_attributes: [ :id, :name, :email, :password, :password_confirmation ])
  end
end
