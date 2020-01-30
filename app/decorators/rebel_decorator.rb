class RebelDecorator < DecoratorBase
  def active
    target.active? ? "Active rebel" : "Supporting Extinction Rebellion"
  end

  def availability
    case target.availability
    when "unavailable"
      "Currently unavailable"
    when "few_hours_a_month"
      "A few hours a month"
    when "few_hours_a_week"
      "A couple of hours a week"
    when "10_hours_a_week"
      "More than 10 hours a week"
    when nil
      "-"
    end
  end
end
