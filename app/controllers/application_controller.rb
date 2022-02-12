class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  #セッションの保存
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  #アクセス制限(非ログインユーザー)
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  #アクセス制限(ログインユーザー)
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts")
    end
  end

end

