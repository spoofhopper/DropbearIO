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


  def send_text_message

    #modify this later to work with the Figaro gem for security: http://richardgmartin.me/web-development/integrate-twilio-texting-ruby-rails-application/
    sid = "AC74db4ed4a2b6e400880205014d384761"
    token = "e6ded52b2286ca47517ae3641be3f54d"
    from = "+14153608229" #my twilio number

    client = Twilio::REST::Client.new sid, token
    #client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    recipients = {
      "+14157938267" => "Morgan's Verizon"
    }

    recipients.each do |key, value|
      client.account.messages.create(
      from: from,
      to: key,
      body: "Hey #{value}, Party tonight!"
      )
      puts "Sent message to #{value}"
    end
  end
  helper_method :send_text_message



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
