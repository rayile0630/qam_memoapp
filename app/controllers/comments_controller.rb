class CommentsController < ApplicationController
    before_action :require_user_logged_in
    def index
       @comments = Comment.all
    
    end
    
    def show
      @post = Post.find(params[:id])
      @comments = @post.comments
    end
    
    def new
       @post = Post.find(params[:post_id])
       @comment = Comment.new
       @comments = @post.comments
    end
    
    def create
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.build(comment_params)
      @comment.post_id = @post.id
      if @comment.save
      flash[:success] = 'コメントを投稿しました。'
        redirect_back(fallback_location: comment_path(@comment.post_id))
      else
        flash.now[:danger] = 'コメントの投稿に失敗しました。'
        render 'comments/new'
      end
    end
  
  

    def destroy
      @post = Post.find(params[:post_id])
      @comment = post.comments.find(params[:id])
      @comment.destroy
      redirect_back(fallback_location: post_path(current_user))
    end

    private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
