class Mailtrain::AddRegistrationJob < ActiveJob::Base
  queue_as :default

  def perform(registration)
    subscribe_to_action_list(registration)
  end

  private

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
