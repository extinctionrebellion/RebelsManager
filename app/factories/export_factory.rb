class ExportFactory
  def self.build(user:, params: {})
    company               = company_access.company
    today                 = Date.current.in_time_zone(ENV['XR_BRANCH_TIMEZONE'])

    export                = Export.new(params)
    export.user           = user
    export.status         = "pending"
    export.format         = "csv"
    export.from_date    ||= Date.parse("2019-01-01") # today.beginning_of_month
    export.to_date      ||= today.end_of_month
    export
  end
end
