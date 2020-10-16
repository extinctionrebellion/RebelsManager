namespace :mailtrain do
  desc "Update rebels list subscriptions (main list)"
  task update_subscriptions_for_main_list: :environment do
    Rebel.all
      .includes(:skills, :tags, :working_groups)
      .find_each do |rebel|
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
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
      sleep 0.1
    end
  end

  task :update_subscriptions_for_local_group, [:local_group_id] => :environment do |task, args|
    local_group = LocalGroup.find(args.local_group_id)
    if local_group.mailtrain_list_id.nil?
      puts "MailTrain list ID is not set for this local group."
    else
      Rebel
        .where(local_group_id: local_group.id)
        .includes(:skills, :tags, :working_groups)
        .find_each do |rebel|
        MailtrainService.instance.add_subscription(
          local_group.mailtrain_list_id,
          {
            "EMAIL": rebel.email,
            "MERGE_NAME": rebel.name,
            "MERGE_STATUS": rebel.status,
            "MERGE_POSTCODE": rebel.postcode,
            "MERGE_PROFILE_URL": rebel.profile_url,
            "MERGE_TAGS": rebel.tags&.pluck(:name)&.join("|"),
            "MERGE_SKILLS": rebel.skills&.pluck(:code)&.join("|"),
            "MERGE_WORKING_GROUPS": rebel.working_groups&.pluck(:code)&.join("|"),
            "FORCE_SUBSCRIBE": "yes",
            "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
          }
        )
        sleep 0.1
      end
    end
  end

  task update_subscriptions: :environment do
    Rebel.all
      .includes(:skills, :tags, :working_groups)
      .find_each do |rebel|
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
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
      sleep 0.5

      if rebel.local_group && !rebel.local_group&.mailtrain_list_id.nil?
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
            "FORCE_SUBSCRIBE": "yes",
            "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
          }
        )
        sleep 0.5
      end
    end
  end

  desc "Add the 'version' custom field to local groups lists"
  task add_version_field_to_local_groups_lists: :environment do
    LocalGroup.where.not(mailtrain_list_id: nil).each do |local_group|
      MailtrainService.instance.create_field(
        local_group.mailtrain_list_id,
        {
          "NAME": "Version"
          "TYPE": "text",
          "VISIBLE": "no"
        }
      )
    end
  end
end
