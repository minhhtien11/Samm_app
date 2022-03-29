class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def show 
    @user = User.find(params[:id])
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    @user.send_activation_email
    flash[:info] = "Please check your email to activate your account."
    redirect_to root_url
    else
    render 'new'
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user&.destroy
    flash[:success] = "User deleted"
    else
    flash[:danger] = "Delete fail!"
    end
    redirect_to users_url
  end

  def edit 
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = " Profile update"
        redirect_to @user
    # Handle a successful update.
    else
      render 'edit'
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
