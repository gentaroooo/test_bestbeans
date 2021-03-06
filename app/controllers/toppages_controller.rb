class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(6)

    else
     @posts = Post.order(id: :desc).page(params[:page]).per(6)
    end
  end
end
