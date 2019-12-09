class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.all.order(id: :desc).page(params[:page]).per(5)
    @user = current_user
    counts(@user)
    @all_ranks = Post.create_all_ranks
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    
  end
  
  def new
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to posts_path
    else
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'posts/new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = '投稿 は正常に更新されました'
      redirect_to posts_url
    else
      flash.now[:danger] = '投稿 は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def understandings
     @posts = Post.where(comprehension: '1').page(params[:page]).per(5)
     @all_ranks = Post.create_all_ranks
  end
  
  def subtles
    @posts = Post.where(comprehension: '2').page(params[:page]).per(5)
    @all_ranks = Post.create_all_ranks
  end
  
  def donotknows
    @posts = Post.where(comprehension: '3').page(params[:page]).per(5)
    @all_ranks = Post.create_all_ranks
  end
  
  def qam_square_understandings
    @posts = Post.where(comprehension: '1').page(params[:page]).per(5)
    @user = current_user
    counts(@user)
    @all_ranks = Post.create_all_ranks
    
  end
  
  def qam_square_subtles
    @posts = Post.where(comprehension: '2').page(params[:page]).per(5)
    @user = current_user
    counts(@user)
    @all_ranks = Post.create_all_ranks
  end
  
  def qam_square_donotknows
    @posts = Post.where(comprehension: '3').page(params[:page]).per(5)
    @user = current_user
    counts(@user)
    @all_ranks = Post.create_all_ranks
  end
  
  def search
    @posts = Post.search(params[:search])
  end
  
  def my_index
    @posts = current_user.posts.order(id: :desc).page(params[:page]).per(7)
    @user = current_user
    counts(@user)
  end
  
  def news
     @posts = Post.all.order(id: :desc).page(params[:page]).per(5)
  end
  
  def rankings
    @all_ranks = Post.create_all_ranks
  end

  private

  def post_params
    params.require(:post).permit(:title, :qmemo, :amemo, :address, :comprehension, :content)
  end
  
  

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end