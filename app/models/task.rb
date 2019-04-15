class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }

  after_update :send_confirmation

  private

  def send_confirmation
    if change_completed && self.completed
      user_email = ENV['USER_SYS']
      color = get_color
      phrase = get_phrase

      # Save the tracking
      Tracking.create({type_tracking:'task', json: {user: user_email, color: color, phrase: phrase}.to_json })

      # Send email
      TaskMailer.confirmation(user_email, message_body(color, phrase)).deliver!
    end
  end

  def message_body(color, phrase)
    "<p style=\"color:"+color+"\">"+phrase+"</p>"
  end

  def get_color
    ["#FF0000", "#000080", "#FCDC04", "#F3947E", "#4D6F94"].sample
  end

  def get_phrase
    ["Parabéns!", "Task concluída!", "Objetivo completo!", "Task completa!", "Atividade finalizada!"].sample
  end

  def change_completed
    (self.completed != self.completed_before_last_save)
  end
end
