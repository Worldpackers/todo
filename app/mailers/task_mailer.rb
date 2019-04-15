class TaskMailer < ApplicationMailer
  def confirmation(user_email, message_body)
    @user_email = user_email
    @message_body = message_body

    mail to: @user_email, subject: "App Rails de To Do - Task"
  end
end
