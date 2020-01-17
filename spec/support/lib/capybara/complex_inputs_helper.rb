# This module will be included in page object classes and in
# system specs.  It can declare low level utility functions for manipulating
# complex inputs.
# eg. :
# - fill_ckeditor
# - pick_date
# - pick_daterange
# - set_range
#  ....
#
# If an input manipulation is really complex (like a date picker), feel free to introduce a new class
# for handling that input and simply use that class in the exposed function here :
#
#   require "capybara/date_picker"
#   def pick_date(input, value)
#     DatePicker.new(input).call(value)
#   end
#
# All those functions are missing from default Capybara driver, some of them might require javascript
# javascript can be run in the following way  :
#
#  ```
#     script = <<-EOJS
#       const receivedValue = arguments[0];
#       const receivedElement = arguments[1];
#
#       console.log("Received value", receivedValue);
#       console.log("Received element", receivedElement);
#     EOJS
#
#     page_element = page.find(".css_selector")
#     page.execute_script(script, "foobar", page_element)
#
#  ```
#
module Capybara::ComplexInputsHelper

  def search_datatable(datatable_wrapper, value)
    search_input = datatable_wrapper.find('.datatable-header input[type="search"]')
    search_input.set(value)
  end

  def choose_from_radios(value, radio_buttons_wrapper)
    if Capybara.current_driver == :rack_test
      radio_buttons_wrapper.find(:radio, value).set(true)
    else
      radio_buttons_wrapper.find('label', text: value).click
    end
  end


  def choose_from_checkboxes(values, check_boxes_container)
    if Capybara.current_driver == :rack_test
      check_boxes_container.all('.checkbox input[type="checkbox"][checked]').each{|input| input.set(false)}
    else
      check_boxes_container.all('.checkbox input:checked + label').each(&:click)
      check_boxes_container.all(:xpath, ".//label[./input[@checked='checked']]").each(&:click)
    end

    values = Array(values)

    values.select(&:present?).each do |value|
      if Capybara.current_driver == :rack_test
        check_boxes_container.find(:checkbox, value).set(true)
      else
        label = check_boxes_container.find('label', text: value)
        label.click
      end
    end
  end

end


