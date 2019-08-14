class ServiceBase
  attr_reader :error
  attr_writer :report_errors, :report_level

  def error_message(default: "Something went wrong.")
    error.respond_to?(:message) ? error.message : default
  end

  def set_error_message(message)
    @error = OpenStruct.new
    @error.message = message
  end

  private

  def catch_error(context: {})
    block_given? ? yield : false
  rescue => e
    Raven.capture_exception(e) if report_errors?
    Rails.logger.debug("#{e.class.name} - #{e.message}")
    Rails.logger.debug("CONTEXT: #{context}")
    e.backtrace.each { |trace| Rails.logger.debug(trace) }
    @error = e
    false
  end

  def report_errors?
    !!@report_errors
  end

  def report_level
    @report_level || "error"
  end
end
