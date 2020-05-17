class ExportsController < BaseController
  def show
    export = current_company.exports.find(params[:id])
    if export.downloadable? && export.generated_by?(current_company_access.id)
      file_url = AwsS3Service.instance.get_object(
        bucket: ENV.fetch('S3_EXPORTS_BUCKET_NAME'),
        key: export.s3_key
      )
      send_data(
        open_and_read(file_url),
        filename: "#{export.company.name} - #{export.export_type} from " +
          "#{export.from_date} to #{export.to_date}.csv",
        type: 'text/csv',
        disposition: 'attachment',
        stream: 'true'
      )
    else
      redirect_to(
        hub_path,
        alert: _("This export is not available anymore. Please export again.")
      ) and return
    end
  end

  def create
    export = ExportFactory.build(
      user: current_user,
      params: export_params
    )
    if export.save
      Exports::ProcessExportService.new(export: export).run
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def export_params
    params.require(:export).permit(
      :export_type,
      :from_date,
      :to_date
    )
  end

  def open_and_read(file_url)
    open(file_url).read
  end
end
