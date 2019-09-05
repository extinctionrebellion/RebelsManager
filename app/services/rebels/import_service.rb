require 'csv'

module Rebels
  class ImportService < ServiceBase
    PreconditionFailedError = Class.new(StandardError)

    attr_reader :csv_import

    def run(params = {})
      context = {
        params: params
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      @csv_import = CsvImport.new(csv_import_params(params))
      if @csv_import.valid?
        process_csv(@csv_import.content)
        true
      else
        false
      end
    end

    private

    def csv_import_params(params)
      params
        .require(:csv_import)
        .permit(
          :content
        )
    end

    def process_csv(content)
      csv = CSV.parse(content, headers: false)
      row_line = 0
      csv.each do |row|
        ActiveRecord::Base.transaction do
          rebel_params = {
            rebel: {
              local_group: row[0]&.strip,
              name: row[1]&.strip,
              email: row[2]&.strip,
              phone: row[3]&.strip,
              postcode: row[4]&.strip,
              language: row[5]&.strip
            }
          }
          service = Rebels::CreateService.new(source: "admin")
          if service.run(ActionController::Parameters.new(rebel_params))
            @csv_import.imports_count += 1
          else
            @csv_import.import_errors << "Line #{row_line}: #{service.error_message}"
          end
        end
        row_line += 1
      end
    end
  end
end
