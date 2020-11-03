class Mailtrain::CreateListFieldsJob < ActiveJob::Base
  queue_as :default

  def perform(mailtrain_list_id)
    create_fields(mailtrain_list_id)
  end

  private

  def create_fields(mailtrain_list_id)
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Postcode",
        "TYPE": "text",
        "VISIBLE": "yes"
      }
    )
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Tags",
        "TYPE": "text",
        "VISIBLE": "yes"
      }
    )
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Profile URL",
        "TYPE": "text",
        "VISIBLE": "no"
      }
    )
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Skills",
        "TYPE": "text",
        "VISIBLE": "no"
      }
    )
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Status",
        "TYPE": "text",
        "VISIBLE": "no"
      }
    )
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Version",
        "TYPE": "text",
        "VISIBLE": "no"
      }
    )
    MailtrainService.instance.create_field(
      mailtrain_list_id,
      {
        "NAME": "Working Groups",
        "TYPE": "text",
        "VISIBLE": "no"
      }
    )
  end
end
