class ProfilesController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @profile = Profile.find_by_user_id(@user)
  end

  def new
    @user.profile = Profile.new
    @profile = @user.profile
  end

  def create
    super
    @profile = @user.profiles.build(profile_params)
    if @profile.save
      flash[:notice] = "Profile written"
      redirect_to :action => 'show'
    else
      render :action => 'new'
    end
  end

  def edit
    puts "----------------"
    @user = current_user
    @profile = Profile.find_by user_id: current_user.id
  end

  def update
    puts "0000000000000"
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
