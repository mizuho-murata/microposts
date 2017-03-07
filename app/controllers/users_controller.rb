class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def show 
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if (current_user !=@user)
       return redirect_to root_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if (current_user !=@user)
       return redirect_to root_path
    end
    if (@user.update(user_profile))
      redirect_to @user
    else
      flash.now[:alert] = "Update Failed"
      render 'edit'
    end
  end
  
  def followings
     @user = User.find(params[:id])
     @followings = @user.following_users
  end
  
  def followers
     @user = User.find(params[:id])
     @followers = @user.follower_users
    
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def user_profile
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :area)
  end
end