# p458, created by hand..
class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy  # p477 added.

  def create 
    @micropost = current_user.microposts.build(micropost_params) #params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []  # p475 added, because home-page now expects it initialized.
      render 'static_pages/home'
    end    
  end

  def destroy
    # p477, added:
    @micropost.destroy
    redirect_back_or root_path
  end

private
  # p478 added:
  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end

  # p436, Never trust parameters from the scary internet, only allow the white list through.
  def micropost_params
    params.require(:micropost).permit(:content)
  end

end
