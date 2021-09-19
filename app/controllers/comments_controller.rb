class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @comments = Post.order(id: :desc).page(params[:page]).per(6)
    @posts = Post.order(id: :desc).page(params[:page]).per(6)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_to root_url
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'コメントは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'コメントは更新されませんでした'
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
