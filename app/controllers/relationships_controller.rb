class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
   @user = User.find(params[:id])
   @followings = @user.followings
  end
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'ユーザをフォローしました。'
    redirect_to user_path(current_user.id)
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'ユーザのフォローを解除しました。'
    redirect_to user_path(current_user.id)
  end
end