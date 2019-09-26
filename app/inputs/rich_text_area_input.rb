class RichTextAreaInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.rich_text_area(attribute_name, merged_input_options)
  end
end