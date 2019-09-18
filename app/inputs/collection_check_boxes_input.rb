class CollectionCheckBoxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  def input(_wrapper_options)
    label_method, value_method = detect_collection_methods
    iopts = {
      :item_wrapper_tag => 'label',
      :item_wrapper_class => options[:item_wrapper_class] || 'field',
      :collection_wrapper_tag => 'div'
     }
    return @builder.send(
      "collection_check_boxes",
      attribute_name,
      collection,
      value_method,
      label_method,
      iopts,
      input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end

  protected

  def collection_block_for_nested_boolean_style
    proc { |builder|
      build_nested_boolean_style_item_tag(builder)
    }
  end

  def build_nested_boolean_style_item_tag(collection_builder)
    # out = ActiveSupport::SafeBuffer.new
    tag = String.new
    tag << '<div class="grid-x">'
    tag << '  <div class="cell shrink">'
    tag <<      collection_builder.check_box
    tag <<      '<div class="custom-checkbox"></div>'
    tag << '  </div>'
    tag << '  <div class="cell auto">'
    tag << '    <span class="label-text">'
    tag <<        collection_builder.text
    tag << '    </span>'
    tag << '  </div>'
    tag << '</div>'
    return tag.html_safe
  end
end
