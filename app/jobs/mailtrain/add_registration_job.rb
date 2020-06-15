class Mailtrain::AddRegistrationJob < ActiveJob::Base
  queue_as :default

  def perform(registration)
    subscribe_to_action_list(registration)
    send_welcome_email(registration)
  end

  private

  def send_welcome_email(registration)
    template_id = nil
    case registration.language
    when "de"
      template_id = 56
      subject = "Prépare-toi aux 14 jours de Rébellion // Notre Avenir - Nos Choix !"
    when "en"
      template_id = 55
      subject = "Prepare yourself for the 14 days of Rebellion // Our Future - Our Choices!"
    when "fr"
      template_id = 56
      subject = "Prépare-toi aux 14 jours de Rébellion // Notre Avenir - Nos Choix !"
    when "nl"
      template_id = 58
      subject = "Bereid je voor op de 14 dagen van de opstand // Onze Toekomst - Onze Keuzes!"
    end
    if !template_id.nil?
      MailtrainService.instance.send_transactional_email(
        template_id,
        {
          "EMAIL": registration.email,
          "SUBJECT": subject
        }
      )
    end
  end

  def subscribe_to_action_list(registration)
    MailtrainService.instance.add_subscription(
      registration.action.mailtrain_list_id,
      {
        "EMAIL": registration.email,
        "MERGE_NAME": registration.name,
        "MERGE_LANGUAGE": registration.language,
        "MERGE_PARTICIPATED_PREVIOUSLY": registration.participated_previously,
        "FORCE_SUBSCRIBE": "yes",
        "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
      }
    )
  end
end
