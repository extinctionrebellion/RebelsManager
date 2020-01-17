# This module will extend Page Objects.
# The purpose is to provide some "macros" usable in a page objects for
# identifying specific elements in the page and generating usual methods concerning those elements
#
# Elements used by page objects will be identified through a special data property "data-purpose"
# This data property will avoid targetting through css selector which could change because of front end
# development decisions.
# A button going from blue to gray should not break a scenario.
#
# These macro will generate usual actions. e.g :
#  - `purpose_link :confirm` will generate a `confirm` method  that clicks on the link
#  - `purpose_input :first_name` will generate a `set_first_name(value)` method
#
# When introducing new complex input helper in Capybara::ComplexInputsHelper, you will probably want to
# add a new macro here for using that macro more easily.
#

module SitePrismExtension

  def purpose_element(purpose, **options)
    element purpose, css_purpose_selector_for(purpose), **options
  end

  def purpose_elements(purpose, elements_name = purpose.to_s.pluralize)
    elements elements_name, css_purpose_selector_for(purpose)
  end

  def purpose_section(purpose, section_class = nil)
    section_class ||= self.const_get(purpose.to_s.camelize)
    section purpose, section_class, css_purpose_selector_for(purpose)
  end

  def purpose_sections(purpose, element_selector = nil, section_class = nil)
    element_selector ||= css_purpose_selector_for(purpose)
    section_class ||= self.const_get(purpose.to_s.camelize)

    elements_name = purpose.to_s.pluralize
    sections elements_name, section_class, element_selector

    define_method("#{purpose}_with") do |identifier_hash|

      self.send("wait_until_#{elements_name}_visible")
      self.send(elements_name).detect do |section|
        identifier_hash.all? do |element, value|
          section_value = case
                            when section.respond_to?("#{element}_value")
                              section.send("#{element}_value")
                            when section.respond_to?("#{element}_input")
                              section.send("#{element}_input").value
                            else
                              section.send(element).text
                          end
          section_value == value
        end
      end
    end

    define_method("#{purpose}_with!") do |identifier_hash|
      element = self.send("#{purpose}_with", identifier_hash)
      element.presence or raise "No #{elements_name.humanize} matches #{identifier_hash}"
    end

    define_method("has_#{purpose}_with?") do |identifier_hash|
      self.send("#{purpose}_with", identifier_hash).present?
    end

  end

  def purpose_input(property_name)
    purpose = "#{property_name}_input"
    purpose_element(purpose)
    define_method("set_#{property_name}") do |value|
      self.send(purpose).set(value)
    end
    define_method("get_#{property_name}") do
      self.send(purpose).value
    end
  end

  def purpose_link(action)
    purpose = "#{action}_link"
    purpose_element(purpose)
    define_method(action) do
      element = self.send(purpose)
      element.click
    end
  end

  def purpose_button(action)
    purpose = "#{action}_button"
    purpose_element(purpose)
    define_method(action) do
      element = self.send(purpose)
      element.click
    end
  end


  def purpose_select(field_name, **options)
    purpose = "#{field_name}_select"
    define_setter(field_name, purpose, options) do |element, value|
      element.find(:option, value).select_option
    end
  end



  def purpose_radio_buttons_wrapper(field_name, **options)
    purpose = "#{field_name}_radio_buttons_wrapper"
    define_setter(field_name, purpose, options) do |element, value|
      choose_from_radios(value, element)
    end
  end

  def purpose_check_boxes_wrapper(field_name, **options)
    purpose = "#{field_name}_check_boxes_wrapper"
    define_setter(field_name, purpose, options) do |element, value|
      choose_from_checkboxes(value, element)
    end
  end

  def purpose_datatable_search(resource_name)
    purpose = "#{resource_name}_datatable"
    purpose_element(purpose)
    define_method("search_#{resource_name}") do |query|
      element = public_send(purpose)
      search_datatable(element, query)
    end
  end


  private

  def define_setter(field_name, purpose, options = {}, &blk)
    purpose_element(purpose, **options)
    define_method("set_#{field_name}") do |*values|
      element = public_send(purpose)
      instance_exec(element, *values, &blk)
    end
  end

  def css_purpose_selector_for(purpose)
    multi_cases = [
      purpose.to_s,
      purpose.to_s.underscore,
      purpose.to_s.camelize(:lower),
      purpose.to_s.dasherize,
    ]
    css_purpose_selectors = multi_cases.map do |cased_purpose|
      %Q'[data-purpose="#{cased_purpose}"]'
    end
    css_purpose_selectors.join(', ')
  end

end

