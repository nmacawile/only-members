module SessionsHelper
    
  def sign_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def signed_in?
    !!current_user
  end
  
  def sign_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end
  
  def remember(user)
    user.remember
    cookies.signed[:user_id] = user.id
    cookies[:remember_token] = user.remember_token
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def admin?
    return false unless signed_in?
    current_user.admin
  end
end
