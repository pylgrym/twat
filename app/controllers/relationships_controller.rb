#p523 added.
class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)

    # p527 removed: redirect_to @user
    respond_to do |format|               # p527
      format.html ( redirect_to @user )  # p527
      format.js                          # p527
    end                                  # p527

  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    
    # p527 removed: redirect_to @user
    respond_to do |format|               # p527
      format.html ( redirect_to @user )  # p527
      format.js                          # p527
    end                                  # p527

  end
end

