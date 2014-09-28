class UsersController < ApplicationController
  # p398, :index added to signed_in_user filter:
  before_filter :signed_in_user, only: [:index, :edit, :update, :following, :followers]    # p387 added, p518 updated.
  before_filter :correct_user,   only: [:edit, :update]    # p391 added.
  before_filter :admin_user,     only: :destroy  # p422 added.

  # p.281, added:	
  def show
  	@user = User.find(params[:id]) # p281.
    @microposts = @user.microposts.paginate(page: params[:page]) # p449.    
  end

  def new
    @user = User.new  # p299  	
  end

  def create # p305 added
     # was:
  	 # @user = User.new(params[:user]) # old 'attr_accessible' style.
     @user = User.new(user_params) # required by 'strong_parameters' style.
  	 if @user.save
       sign_in @user  #p361 added.
  	   flash[:success] = "Welcome to the Sample App!"  # p317 added. ('myblog' suggests it disappears again at some point.)
  	   # handle success-save
  	   redirect_to @user  # p314 added.
  	 else
  	   render 'new'
  	 end
  end #..create.

  # GET /users/1/edit
  def edit                          # p375 added.
    # p391-removed: @user = User.find(params[:id])  # p375 added.
  end

  def update # p381 added
    # p391-removed: @user = User.find(params[:id])
    if @user.update_attributes(user_params) # was: params[:user] (must be user_params get filter strong params instead!)
      #handle a successful update.
      flash[:success] = "Profile updated"     # p384 added.
      sign_in @user                           # p384 added.
      redirect_to @user                       # p384 added.
    else
      render 'edit'
    end
  end  

  def following # p518 added.
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers # p518 added.
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def index # p399 added.
    @users = User.paginate(page: params[:page]) # p409 added.   
    # p409 gone: @users = User.all # p399 added.
  end

  def destroy # p420 added.
    User.find(params[:id]).destroy   # so before-filter can't help us here..
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

#added p317 BY ME to work..
private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # p387 introduced, p457 moved to sessions-helper:
  ## def signed_in_user    # p387 added.
  ##   unless signed_in?   # p395 changed.
  ##     store_location    # p395 changed. 
  ##     redirect_to signin_path, notice: "Please sign in."  # p387 orig.
  ##   end                 # p395 changed.
  ## end   

  def correct_user      # p391 added.
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user  # p422 added.
    redirect_to(root_path) unless current_user.admin?
  end

end
