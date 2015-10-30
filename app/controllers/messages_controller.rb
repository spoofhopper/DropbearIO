class MessagesController < ApplicationController

  include Webhookable

  #after_filter :set_header #Set up the response header in the set_header method which gets called in after_filter method.

  skip_before_action :verify_authenticity_token

  def index
    if current_user
      set_user
      set_group
      @messages = Group.find(@group).messages
    else new_user
      redirect_to root_path
    end
  end

  def show
    set_user
    set_group
    @message = get_message
  end

  def new
    if current_user
      set_user
      set_group
      @message = Message.new
    else new_user
      redirect_to root_path
    end
  end

  def create
    if current_user
      set_user
      set_group
      @message = Message.new(message_params)
      @message.user = @user
      @message.group = @group
      if @message.save
        redirect_to user_group_messages_path(@group, @message)
      else
        render 'new'
      end
    else new_user
      redirect_to root_path
    end
  end


  def edit
    set_user
    set_group
    @message = get_message
  end

  def update
    set_user
    set_group
    @message = get_message
    if @message.update(message_params)
      redirect_to user_group_messages_path(@group, @message)
    else
      render 'edit'
    end
  end

  def destroy
    set_user
    set_group
    @message = get_message
    @message.destroy
    redirect_to user_group_messages_path(@user, @group)
  end




  private

    def message_params
      params.require(:message).permit(:header, :body, :link, :image_url, :date, :sent, :scheduled, :group_id)
    end

    def get_message
      Message.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_user
      @user = User.find(session[:user_id])
    end


end
