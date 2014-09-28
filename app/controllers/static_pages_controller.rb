class StaticPagesController < ApplicationController
  # "clean sample_app"
  
  def home
    if signed_in?
      @micropost = current_user.microposts.build  # p463 added.
      @feed_items = current_user.feed.paginate(page: params[:page]) # p471 added.
    end
  end

  def help
  end
 
  def about # Added p.101.
  end

  def contact # Added p.199.
  end
end
