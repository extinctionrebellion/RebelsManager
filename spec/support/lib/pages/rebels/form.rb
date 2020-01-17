module Pages
  module Rebels
    class Form < BasePage

      purpose_input :email
      purpose_input :name
      purpose_input :phone

      purpose_select :language

      purpose_button :save

    end
  end
end
