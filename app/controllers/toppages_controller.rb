class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = Post.order(created_at: :desc).limit(5)
      @posts_my = current_user.posts.order(created_at: :desc).limit(5)
    end
  end
end
