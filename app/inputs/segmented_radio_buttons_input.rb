class SegmentedRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input(_wrapper_options = nil)
    label_method, value_method = detect_collection_methods
    input_options[:item_wrapper_tag] = "li"
    input_options[:item_wrapper_class] = "segmented-control-item"
    @builder.send("collection_radio_buttons",
                  attribute_name,
                  collection,
                  value_method,
                  label_method,
                  input_options,
                  input_html_options,
                  &collection_block_for_nested_boolean_style)
  end

  def item_wrapper_class
    ""
  end
end