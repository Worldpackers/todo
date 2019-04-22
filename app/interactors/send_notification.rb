class SendNotification
  include Interactor

  def call
    if task_mailer = TaskMailer.confirmation(context.user_email, context.color, context.phrase)
      context.task_mailer = task_mailer.deliver!
    else
      context.fail!(message: "Could not send notification!")
    end
  end
end
