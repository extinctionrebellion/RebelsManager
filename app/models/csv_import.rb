class CsvImport
  include ActiveModel::Model

  attr_accessor :content, :import_errors, :imports_count

  validates :content,
            presence: { message: "The content is empty" }

  def initialize(attributes = nil)
    super(attributes)
    self.import_errors = []
    self.imports_count = 0
  end
end
