class UsersController < ApplicationController

  before_action :login_required, except: [:new, :create]

  def index
      @users = User.all
  end

  def show
      @user = get_user
  end

  def new
      @user = User.new
  end

  def create
      if User.create(user_params)
        redirect_to root_path
        flash[:notice] = "Successfully created user!"
      else
        render 'new'
      end
  end

  def edit
      @user = get_user
  end

  def update
    @user = get_user

    if @user.update user_params
      flash[:notice] = "Successfully updated user!"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = get_user
    @user.destroy
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :username, :password, :twilio_number, :twilio_sid, :twilio_token, :admin)
  end

  def get_user
    User.find(params[:id])
  end

end
