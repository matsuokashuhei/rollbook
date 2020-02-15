class UsersController < ApplicationController
  before_action :admin_user!, only: [:index, :create, :destroy]
  #before_action :admin_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :my_user!

  def index
    #@users = User.where("role >= ?", current_user.role).decorate
    @users = User.all.decorate
  end

  def new
    @user = User.new(role: "3", status: "1")
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.password = "from1996"
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), notice: "ユーザーを登録しました。初期パスワードは「from1996」です。" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "ユーザーを変更しました。" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:name, :email, :school_id, :role, :status)
    end
    def my_user!
      unless current_user.admin?
        redirect_to root_path unless @user == current_user
      end
    end

end
