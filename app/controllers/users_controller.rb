class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user,{only: [:index,:show,:edit,:update]}
  before_action :forbid_login_user,{only: [:new,:create,:login,:login_form]}
  before_action :ensure_correct_user,{only: [:edit,:update]}

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # login_form
  def login_form
    @user = User.find_by(email: params[:email],password: params[:password])

  end

  # login
  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts")
    else
      @error_message = "メールアドレスかパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render :login_form
    end
  end

  # logout
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end

  # ユーザー確認
  def ensure_correct_user
    if @curren_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :profile_text, :password)
    end
end
