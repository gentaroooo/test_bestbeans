class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    else
    # ログインしていない場合は全ての投稿を表示する
    @post = Post.all
    end
  end
end