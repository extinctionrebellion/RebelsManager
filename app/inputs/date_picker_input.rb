class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    unless string?
      input_html_classes.unshift("string")
      input_html_options[:type] ||= "text"
      input_html_options[:data] ||= {}
      input_html_options[:data].merge!({ controller: "datepicker", target: "datepicker.input" })
      input_html_options[:placeholder] ||= "-- / -- / ----"
    end

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    template.content_tag(:div, class: "input-with-icon right-icon") do
      out = ActiveSupport::SafeBuffer.new
      out << @builder.text_field(attribute_name, merged_input_options) +
      out << content_tag(:i, nil, class: "input-icon fa fa-calendar")
      out
    end.html_safe
  end
end
