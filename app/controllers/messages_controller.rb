class MessagesController < ApplicationController

  def index
    set_group
    @messages = Group.find(@group).messages
  end

  def show
    set_group
    @message = get_message
  end

  def new
    set_group
    @message = Message.new
  end

  def create
    set_group
    @message = Message.new(message_params)
    @message.group = @group
    if @message.save
      redirect_to group_message_path(@group, @message)
    else
      render 'new'
    end
  end


  def edit
    set_group
    @message = get_message
  end

  def update
    set_group
    @message = get_message
    if @message.update(message_params)
      redirect_to group_message_path(@group, @message)
    else
      render 'edit'
    end
  end

  def destroy
    set_group
    @message = get_message
    @message.destroy
    redirect_to group_messages_path(@group)
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


end
