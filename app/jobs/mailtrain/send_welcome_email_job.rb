class Mailtrain::SendWelcomeEmailJob < ActiveJob::Base
  queue_as :default

  def perform(rebel)
    send_welcome_email(rebel)
  end

  private

  def send_welcome_email(rebel)
    template_id = nil
    case rebel.language
    when "en"
      template_id = 77
      subject = "Welcome to the rebellion! ⏳🌎"
    when "fr"
      template_id = 76
      subject = "Bienvenue dans la rébellion! ⏳🌎"
    when "nl"
      template_id = 78
      subject = "Welkom bij de opstand! ⏳🌎"
    end
    if !template_id.nil?
      MailtrainService.instance.send_transactional_email(
        template_id,
        {
          "EMAIL": rebel.email,
          "SUBJECT": subject
        }
      )
    end
  end
end
