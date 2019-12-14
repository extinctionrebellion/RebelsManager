module CsvExport
  require 'csv'
  
  InvalidRecordsError = Class.new(StandardError)

  def self.for_model(records:, records_class:, context: nil)
    reportable_class = records_class
    records_are_all_active_record = reportable_class.ancestors.include?(ActiveRecord::Base) &&
      records.all? { |record| record.class == reportable_class }

    raise InvalidRecordsError unless records_are_all_active_record

    model_csv_generator_class = "#{self.name}::#{reportable_class}"
    model_csv_generator_class.constantize
                             .new(records, context)
                             .generate
  end

  class ExportGenerator
    def initialize(records, context = {})
      # transform in case is an ActiveRecord::Relation Object
      @records = records.to_a
      @context = context
    end

    def header
      raise 'define a header for the csv'
    end

    def extract_info
      raise 'define how to extract the data from the record'
    end

    def generate
      CSV.generate do |csv|
        csv << header

        @records.each do |record|
          csv << extract_info(record)
        end
      end
    end
  end
end
