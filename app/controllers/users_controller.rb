class UsersController < ApplicationController
  before_filter  :signed_in_user,
                 only: [:edit, :update, :index, :destroy, :following, :followers]
  before_filter  :correct_user,    only: [:edit, :update]
  before_filter  :admin_user,      only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    redirect_to root_path if signed_in?

    @user = User.new
  end

  def create
    redirect_to root_path if signed_in?

    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title  = "Followers"
    @user   = User.find(params[:id])
    @users  = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
