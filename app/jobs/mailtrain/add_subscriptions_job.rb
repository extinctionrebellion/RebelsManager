class Mailtrain::AddSubscriptionsJob < ActiveJob::Base
  queue_as :default

  def perform(rebel)
    subscribe_to_rebels_list(rebel)
    subscribe_to_rebels_local_list(rebel)
  end

  private

  def subscribe_to_rebels_list(rebel)
    MailtrainService.instance.add_subscription(
      ENV['MAILTRAIN_REBELS_LIST_ID'],
      {
        "EMAIL": rebel.email,
        "MERGE_NAME": rebel.name,
        "MERGE_SUBSCRIPTION_DATE": rebel.created_at.to_date.to_s,
        "MERGE_LOCAL_GROUP": rebel.local_group&.name,
        "MERGE_LANGUAGE": rebel.language,
        "MERGE_POSTCODE": rebel.postcode,
        "MERGE_PROFILE_URL": rebel.profile_url,
        "MERGE_TAGS": rebel.tags&.pluck(:name)&.join("|"),
        "MERGE_SKILLS": rebel.skills&.pluck(:code)&.join("|"),
        "MERGE_WORKING_GROUPS": rebel.working_groups&.pluck(:code)&.join("|"),
        "MERGE_VERSION": rebel.version,
        "FORCE_SUBSCRIBE": "yes",
        "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
      }
    )
  end

  def subscribe_to_rebels_local_list(rebel)
    return if rebel.local_group&.mailtrain_list_id.nil?
    MailtrainService.instance.add_subscription(
      rebel.local_group.mailtrain_list_id,
      {
        "EMAIL": rebel.email,
        "MERGE_NAME": rebel.name,
        "MERGE_STATUS": rebel.status,
        "MERGE_POSTCODE": rebel.postcode,
        "MERGE_PROFILE_URL": rebel.profile_url,
        "MERGE_TAGS": rebel.tags&.pluck(:name)&.join("|"),
        "MERGE_SKILLS": rebel.skills&.pluck(:code)&.join("|"),
        "MERGE_WORKING_GROUPS": rebel.working_groups&.pluck(:code)&.join("|"),
        "MERGE_VERSION": rebel.version,
        "FORCE_SUBSCRIBE": "yes",
        "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
      }
    )
  end
end
