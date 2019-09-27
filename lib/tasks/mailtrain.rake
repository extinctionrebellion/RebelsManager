namespace :mailtrain do
  desc "Update rebels list subscriptions"
  task update_subscriptions: :environment do
    Rebel.all.find_each do |rebel|
      MailtrainService.instance.add_subscription(
        ENV['MAILTRAIN_REBELS_LIST_ID'],
        {
          "EMAIL": rebel.email,
          "MERGE_NAME": rebel.name,
          "MERGE_LOCAL_GROUP": rebel.local_group&.name,
          "MERGE_LANGUAGE": rebel.language,
          "MERGE_POSTCODE": rebel.postcode,
          "MERGE_PROFILE_URL": rebel.profile_url,
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
    end
  end
end
