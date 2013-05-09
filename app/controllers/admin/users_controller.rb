class Admin::UsersController < Admin::BaseController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.all(order: "email")
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save 
  		flash[:success] = "User has been created."
  		redirect_to admin_users_path
  	else
  		flash.now[:error] = "User has not been created."
  		render :new
  	end
  end

  def show
  end

  def edit
  end

  def update
    @user.skip_reconfirmation!
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update_attributes(params[:user])
      flash[:success] = "User has been updated."
      redirect_to admin_users_path
    else
      flash.now[:error] = "User has not been updated."
      render :edit
    end
  end

  def destroy
    if @user == current_user
      flash[:error] = "You cannot delete yourself!"
    else
      @user.destroy
      flash[:success] = "User has been deleted."
    end
    redirect_to admin_users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # def user_params
    #   params.require(:user).permit(:name, :email, :password)
    # end
end
