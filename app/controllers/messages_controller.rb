class MessagesController < ApplicationController
  def index
    @message = current_user.sendmessages
  end

  def new
    @message = current_user.sendmessages.new
    @chosen_reciver = User.find_by(id: params[:reciver_id].to_i) if params[:reciver_id]
  end

  def create

    @message = current_user.sendmessages.create(permitted_params[:message].merge!(sender_id: current_user.id))
    if  @message.save
      flash[:notice] = "Message sent!"
      redirect_to "show"
    else
      flash[:error] = @message.errors.full_messages.to_sentence
      render "new"
    end
  end

  def destroy
    @message = current_user.messages.destroy params[:id]
  end

  def show
    @allmessages = current_user.sendmessages + current_user.recivmessages
  end

  def outbox
    @outmessage = current_user.sendmessages
  end

  def inbox
    @inmessage = current_user.recivmessages
  end

  private

  def permitted_params
    params.permit( message: [ :body, :reciver_id ])
  end
end
