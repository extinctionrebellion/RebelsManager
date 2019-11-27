namespace :mailtrain do
  desc "Update rebels list subscriptions"
  task update_subscriptions: :environment do
    Rebel.all
      .includes(:skills, :working_groups)
      .find_each do |rebel|
      MailtrainService.instance.add_subscription(
        ENV['MAILTRAIN_REBELS_LIST_ID'],
        {
          "EMAIL": rebel.email,
          "MERGE_NAME": rebel.name,
          "MERGE_LOCAL_GROUP": rebel.local_group&.name,
          "MERGE_LANGUAGE": rebel.language,
          "MERGE_POSTCODE": rebel.postcode,
          "MERGE_PROFILE_URL": rebel.profile_url,
          "MERGE_TAGS": rebel.tag_list,
          "MERGE_SKILLS": rebel.skills&.pluck(:code)&.join("|"),
          "MERGE_WORKING_GROUPS": rebel.working_groups&.pluck(:code)&.join("|"),
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )

      if rebel.local_group && !rebel.local_group&.mailtrain_list_id.nil?
        MailtrainService.instance.add_subscription(
          rebel.local_group.mailtrain_list_id,
          {
            "EMAIL": rebel.email,
            "MERGE_NAME": rebel.name,
            "MERGE_STATUS": rebel.status,
            "MERGE_POSTCODE": rebel.postcode,
            "MERGE_PROFILE_URL": rebel.profile_url,
            "MERGE_TAGS": rebel.tag_list,
            "MERGE_SKILLS": rebel.skills&.pluck(:code)&.join("|"),
            "MERGE_WORKING_GROUPS": rebel.working_groups&.pluck(:code)&.join("|"),
            "FORCE_SUBSCRIBE": "yes",
            "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
          }
        )
      end
    end
  end
end
