class RebelDecorator < DecoratorBase
  def availability
    case target.availability
    when "unavailable"
      _("Currently unavailable")
    when "few_hours_a_month"
      _("A few hours a month")
    when "few_hours_a_week"
      _("A couple of hours a week")
    when "10_hours_a_week"
      _("More than 10 hours a week")
    when nil
      "-"
    end
  end
end
