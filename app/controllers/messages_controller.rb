class MessagesController < ApplicationController
  def index
    @messages = current_user.sendmessages + current_user.recivmessages
  end

  def new
    @message = current_user.sendmessages.new
    @chosen_reciver = User.find_by(id: params[:reciver_id].to_i) if params[:reciver_id]
  end

  def create
    @arr = User.where(params[:reciver_ids])
    @arr.each do |user|
      @message = current_user.sendmessages.create(permitted_params[:message].merge!(sender_id: current_user.id, reciver_id: user.id))
    end
    redirect_to messages_path
  end

  def destroy
    @message = current_user.messages.destroy params[:id]
  end

  def show
    @messages = current_user.messages.search(params[:search]).filter( params[:message] ? params[:message][:user_id] : nil)
    @messages = @messages.paginate(:per_page => 5, :page => params[:page])
  end

  def outbox
    @messages = current_user.sendmessages
    @messages = Message.search(params[:search]).paginate(:per_page => 4, :page => params[:page])
  end

  def inbox
    @messages = current_user.recivmessages
    @messages = Message.search(params[:search]).paginate(:per_page => 4, :page => params[:page])
  end

  def readed
    @message = Message.find_by(id: params[:id])
    @message.update_attributes(:readed => params[:readed])
    flash[:success] = 'The message was marked as read.'
    redirect_to messages_path
  end

  def archived
    @message = Message.find_by(id: params[:id])
    @message.update_attributes(:archived => params[:archived])
    flash[:success] = 'The message was marked as read.'
    redirect_to messages_path
  end

  def archiv
    @messages = Message.archived
  end

  def send_mail
    mail = Pony.mail(
        :to => params[:message][:reciver][:email],
        :from => params[:message][:sender][:name],
        :headers => { 'Content-Type' => 'text/html' },
        :body =>  params[:message][:body],
        :via => :smtp,
        :via_options => {
            :address              => "smtp.gmail.com",
            :port                 => 587,
            :enable_starttls_auto => true,
            :user_name            => ENV["GMAIL_USERNAME"],
            :password             => ENV["GMAIL_PASSWORD"],
            :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
            :domain               => ENV["DOMAIN"], # the HELO domain provided by the client to the server
        } )
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Email was successfully sended.' }
      format.json { head :no_content }
    end
  end

  private

  def permitted_params
    params.permit( message: [:readed, :archived, :body, reciver_ids:[]])
  end
end
