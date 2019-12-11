class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :frendlists, :likes]
  before_action :correct_user, only: [:show, :edit, :update,]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィール は正常に更新されました'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'プロフィール は更新されませんでした'
      render :edit
    end
  end

  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def friendlists
    @user = User.find(params[:id])
    @friendlists = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end
end

  def correct_user
    if current_user.id != params[:id]
      redirect_to login_url
    end
  end  
    #こんな使い方があるのですね！時間過ぎてるのにありがとうございます。はい、ありがとうございました。助かります。
    #はい、頑張ります。#はい、色々似たような記述探して理解してみます
# ジャストアイデアですが、、、さっき私がかいたのはこういうイメージです
# if current_user.id != params[:id]
# redirect login_url
# end
# いえいえ、そろそろ失礼します！がんばってください！
# あくまで参考ですので、きちんと理解しながら書いてくださいね！

