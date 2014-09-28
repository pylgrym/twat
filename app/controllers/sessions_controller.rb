class SessionsController < ApplicationController

  def new
  end

  def create
  	#render 'new' # p337 added, p339 removed.
  	# p339 added, take#2:
  	user = User.find_by_email(params[:session][:email])
  	if user && user.authenticate( params[:session][:password])
  		#sign the user in and redirect to the user's show-page.
  		sign_in user       # p343
  		redirect_back_or user # p395, was: redirect_to user   # p343
  	else
  		# flash[:error] = 'Invalid email/password combination' # Not quite right! p339
  		flash.now[:error] = 'Invalid email/password combination' # p342
  		render 'new'
  	end
  end

  def destroy
    #p362 added:
    sign_out
    redirect_to root_path
  end

end
