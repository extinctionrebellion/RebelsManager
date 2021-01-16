# coding: utf-8
module UiHelper
  def callout(type, content:, tiny: false, link_label: nil, link_href: nil, link_options: {})
    out = ActiveSupport::SafeBuffer.new
    if link_label && link_href
      out << content_tag(:div, class: "cell small-12 medium-shrink") do
        if tiny
          link_to(link_label, link_href, link_options.merge({ class: "tiny hollow #{type} button small-only-expanded no-margin-bottom" }))
        else
          link_to(link_label, link_href, link_options.merge({ class: "small hollow #{type} button small-only-expanded no-margin-bottom" }))
        end
      end
    end
    out = content_tag(:div, class: "#{type} callout #{tiny ? "callout--tiny" : nil}") do
      content_tag(:div, class: "grid-x align-middle") do
        content_tag(:div, class: "cell small-12 medium-auto") do
          content_tag(:strong, content) + content_tag(:div, nil, class: "spacer-1 show-for-small-only")
        end + out
      end
    end
    out.html_safe
  end

  def close_modal_button
    content_tag(:button, "data-close": "", class: "close-button", "aria-label": "Close modal", type: "button") do
      content_tag(:span, raw("&times;"), "aria-hidden": true)
    end.html_safe
  end

  def info_header(label)
    content_tag(:div, class: "info__header grid-x grid-padding-x") do
      content_tag(:div, class: "cell small-12") do
        content_tag(:h4, label)
      end
    end
  end

  def info_line(label, &block)
    out = ActiveSupport::SafeBuffer.new
    out << content_tag(:div, class: "info__line grid-x grid-padding-x") do
      out_cells = ActiveSupport::SafeBuffer.new
      out_cells << content_tag(:div, class: "cell small-12") do
        content_tag(:strong, label, class: "info__line__label")
      end
      out_cells << content_tag(:div, class: "cell small-12") do
        yield block
      end
      out_cells
    end
    out << content_tag(:div, nil, class: "spacer-1")
    out
  end

  def section_heading(heading:, extra: nil, spacing: :hr, count: nil, icon: nil)
    out = ActiveSupport::SafeBuffer.new
    if spacing == :hr
      out << content_tag(:div, class: "grid-x") do
        content_tag(:div, class: "cell auto") do
          content_tag(:hr)
        end
      end
    elsif spacing == :spacer
      out << content_tag(:div, nil, class: "spacer--vertical spacer--vertical--2")
    end
    out << content_tag(:div, class: "grid-x section-heading align-middle") do
      heading_cell_classes = "cell small-12 large-auto"
      extra_cell_classes = "cell small-12 large-shrink"
      out2 = ActiveSupport::SafeBuffer.new
      out2 << content_tag(:div, class: heading_cell_classes) do
        content_tag(:h3, class: "no-margin-bottom #{icon ? 'with-icon' : nil}") do
          out3 = ActiveSupport::SafeBuffer.new
          out3 << render("layouts/icons/#{icon}") if icon
          out3 << content_tag(:span, heading)
          out3 << content_tag(:span, count, class: "badge") if count
          out3
        end
      end
      out2 << content_tag(:div, class: extra_cell_classes) do
        if extra.kind_of?(Array)
          out3 = ActiveSupport::SafeBuffer.new
          out3 << content_tag(:div, nil, class: "spacer-1 hide-for-large")
          extra.reject(&:nil?).each { |e| out3 << e + " " }
          out3
        else
          extra
        end
      end
      out2
    end
    out << content_tag(:div, nil, class: "spacer-1")
    out.html_safe
  end
end
