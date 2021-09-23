class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @comments = Post.order(id: :desc).page(params[:page]).per(6)
    @posts = Post.order(id: :desc).page(params[:page]).per(6)
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      # flash[:success] = 'コメントを投稿しました。'
      # redirect_back(fallback_location: root_path)
      render :index
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)


  end
end
