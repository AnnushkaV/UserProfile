class UserMailer < ApplicationMailer
  default form: 'mytestapp@mail.localhost'

  def welcome_email(message)
    @message = message
    email_with_name = %("#{@message.reciver.name}" <#{@message.reciver.email}>)
    mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
  end
end
