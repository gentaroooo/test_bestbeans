class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :destroy]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(8)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(8)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(8)
    counts(@user)
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page]).per(6)
    counts(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if current_user.update(user_params)
       flash[:success] = 'ユーザ情報を変更しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザ情報の変更に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
