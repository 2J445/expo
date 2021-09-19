class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy ]
  before_action :current_user, only: [:destroy, :edit, :new]
  before_action :require_user_logged_in, only: [:edit]
  before_action :set_search


  # GET /posts or /posts.json
  def index
     @pagy, @posts = pagy(Post.order(id: :desc))
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    if @post.user == current_user
      redirect_to '/'
    end
  end

  # GET /posts/1/edit
  def edit
  @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = '作品を投稿しました。'
      redirect_to root_url
    else
      @pagy, @posts = pagy(current_user.posts.order(id: :desc))
      flash.now[:danger] = '作品の投稿に失敗しました。'
      render 'posts/new'
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = '正常に更新されました'
      redirect_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = '作品を削除しました。'
    redirect_to("/")
  end
  
  def search
    @pagy,@search_posts = pagy(@q.result(distinct: true).order(id: :desc), items:10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:photo, :title, :explanation)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to root_url
      end
    end
    
    
    
    def set_search
      @q = Post.ransack(params[:q])
    end
  
end
