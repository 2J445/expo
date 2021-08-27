class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = Post.order(created_at: :desc)
    end
  end
end
