class TaskMailer < ApplicationMailer
  def confirmation(user_email, color, phrase)
    @user_email = user_email
    @color = color
    @phrase = phrase

    mail to: @user_email, subject: "App Rails de To Do - Task"
  end
end
