module Exports
  class ProcessExportService < ServiceBase
    attr_reader :export

    def initialize(export:)
      @export = export
    end

    def run
      catch_error do
        run!
      end
    end

    def run!
      export.update_column :status, "processing"
      case export.export_type
      when "rebels"
        ExportRebelsJob.perform_later(export: export)
      end
      true
    end
  end
end
