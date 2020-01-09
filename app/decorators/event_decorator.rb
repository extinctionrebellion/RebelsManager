class EventDecorator < DecoratorBase
  def facebook_button
    link_to(target.facebook_url, class: "tiny hollow button") do
      content_tag(:span, class: "inline-icon inline-icon--bolder", data: { tooltip: true }, title: _("See details on Facebook")) do
        "facebook"
      end
    end
  end

  def ends_at(date_only: false)
    if date_only
      l(target.ends_at.to_date, format: :long)
    else
      l(target.ends_at, format: :long)
    end
  end

  def excerpt
    truncate(target.description, length: 200)
  end

  def starts_at(date_only: false)
    if date_only
      l(target.starts_at.to_date, format: :long)
    else
      l(target.starts_at, format: :long)
    end
  end
end
