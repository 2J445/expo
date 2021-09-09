class ToppagesController < ApplicationController
  
  def index
    #検索フォーム
    @q = Post.ransack(params[:q])
    @search_posts = @q.result(distinct: true)
    
    @all_post = Post.all
    @user = User.all
    @posts = Post.order(created_at: :desc).limit(5)
    @favorite_posts = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @follower_users = User.find(Relationship.group(:follow_id).order('count(follow_id) desc').limit(5).pluck(:follow_id))
    
    if logged_in?
      @my_posts = current_user.posts.order(created_at: :desc).limit(5)
    end
    
  end
  
end