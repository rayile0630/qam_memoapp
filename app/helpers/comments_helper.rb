module CommentsHelper
    
    def create
      post = Post.find(params[:post_id])
      @comment = post.comments.build(comment_params)
      if @comment.save
          flash[:succrss] = "コメントしました"
          redirect_back(fallback_location: post_url(post.id))
      else
          flash[:danger] = "コメントできません"
          redirect_back(fallback_location: post_url(post.id))
      end
    end
    
    def destroy
      post = Post.find(params[:post_id])
      @comment = image.comments.find(params[:id])
      @comment.destroy
      redirect_back(fallback_location: post_path(post))
    end
end
