class MessagesController < ApplicationController

  include Webhookable

  #after_filter :set_header #Set up the response header in the set_header method which gets called in after_filter method.

  skip_before_action :verify_authenticity_token

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

#   client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    client = Twilio::REST::Client.new sid, token
    #client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    recipients = {
      "+14157938267" => "Morgz"
    }

    recipients.each do |key, value|
      client.account.messages.create(
      from: from,
      to: key,
      body: "yo #{value}, Twilio party tonight!",
      #media_url: "http://www.quickmeme.com/img/c9/c97933e11761606628ff85bc073c3e188267a77b100642f0162973bfd0a24994.jpg"
      )
      puts "Sent message to #{value}"

    end
    render_twiml response
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
