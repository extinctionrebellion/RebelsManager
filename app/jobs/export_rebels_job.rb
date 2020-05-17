require "csv"

class ExportRebelsJob < ApplicationJob
  queue_as :default

  def perform(export:)
    user = export.user
    if user.local_group?
      rebels = local_group.rebels
    else
      rebels = Rebel.all
    end
    csv_string      = CsvReport.for_model(
                        records: rebels,
                        records_class: Rebel,
                        context: {
                          date_format: :day_month_year,
                          local_group: user.local_group
                        }
                      )
    filename        = "#{SecureRandom.urlsafe_base64}.#{export.format}"
    if upload_exported_file(csv_string, filename)
      export.update(
        s3_key: filename,
        status: "uploaded"
      )
    end
    UserMailer.download_export(export).deliver_later
    return csv_string
  end

  private

  def upload_exported_file(csv_string, filename)
    AwsS3Service.instance.upload_from_string(
      bucket: ENV.fetch('S3_EXPORTS_BUCKET_NAME'),
      filename: filename,
      body: csv_string
    )
  end
end
