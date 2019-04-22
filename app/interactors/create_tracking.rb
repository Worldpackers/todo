class CreateTracking
  include Interactor

  def call
    context.user_email = ENV['USER_SYS']
    context.color = get_color
    context.phrase = get_phrase

    tracking = Tracking.create({type_tracking:'task', json: {user: context.user_email, color: context.color, phrase: context.phrase}.to_json })

    if tracking.valid?
      context.create_tracking = tracking
    else
      context.fail!(message: "Could not create tracking")
    end
  end

  def get_color
    ["#FF0000", "#000080", "#FCDC04", "#F3947E", "#4D6F94"].sample
  end

  def get_phrase
    ["Parabéns!", "Task concluída!", "Objetivo completo!", "Task completa!", "Atividade finalizada!"].sample
  end
end
