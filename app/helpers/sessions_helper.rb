module SessionsHelper

  #p349 added:
  def sign_in(user)
  	cookies.permanent[:remember_token] = user.remember_token
  	self.current_user = user
  end

  #p356 added:
  def signed_in?
  	!current_user.nil?
  end
  
  #p363 added:
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  #p352 added:
  def current_user=(user)
  	@current_user = user
  end

  #p353 added:
  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  #p392 added:
  def current_user?(user)   
    user == current_user
  end 

  #p457, moved here from users-controller:
  def signed_in_user    # p387 added.
    unless signed_in?   # p395 changed.
      store_location    # p395 changed. 
      redirect_to signin_path, notice: "Please sign in." # p387 orig, p395 updated.
    end                 # p395 changed.
  end   
  
  # p394 added:
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # p394 added:
  def store_location
    session[:return_to] = request.fullpath
  end       

end
