class Mailtrain::DeleteSubscriptionsJob < ActiveJob::Base
  queue_as :default

  def perform(email, local_group_id)
    unsubscribe_from_rebels_list(email)
    unsubscribe_from_rebels_local_list(email, local_group_id)
  end

  private

  def unsubscribe_from_rebels_list(email)
    MailtrainService.instance.delete_subscription(
      ENV['MAILTRAIN_REBELS_LIST_ID'],
      {
        "EMAIL": email
      }
    )
  end

  def unsubscribe_from_rebels_local_list(email, local_group_id)
    local_group = LocalGroup.find_by(id: local_group_id)
    return if local_group&.mailtrain_list_id.nil?
    MailtrainService.instance.delete_subscription(
      local_group.mailtrain_list_id,
      {
        "EMAIL": email
      }
    )
  end
end
