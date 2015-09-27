class MessagesController < ApplicationController

  def index
    @messages = Messages.all
  end

  def show
    @message = get_message
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message
    else
      render 'new'
    end
  end


  def edit
    @message = get_message
  end

  def update
    @message = get_message
    if @message.update(message_params)
      redirect_to @message
    else
      render 'edit'
    end
  end

  def destroy
    @message = get_message
    @message.destroy
    redirect_to messages_path
  end




  private

    def message_params
      params.require(:message).permit(:header, :body, :link, :image_url, :date, :sent, :scheduled, :group_id)
    end

    def get_message
      Message.find(params[:id])
    end

end
