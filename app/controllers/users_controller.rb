class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :edit]

  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc), items: 10)
    counts(@user)
    
    @followings = @user.followings.limit(5)
    counts(@user)
    @followers = @user.followers.limit(5)
    counts(@user)
    @likes = @user.favorite_posts.limit(5)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました。'
      redirect_to '/'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to '/'
    end
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = '正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def destroy
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes
     @user = User.find(params[:id])
    @pagy,  @likes = pagy(@user.favorite_posts)
    counts(@user)
  end
  
  private
  
  def set_image
      @image = Image.find(params[:id])
  end
    
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :self_introduction)
  end
end
