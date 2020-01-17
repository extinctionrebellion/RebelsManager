module Pages
  module Rebels
    class Index < BasePage
      set_url '/rebels'

      purpose_link :add_new_rebel

      purpose_datatable_search :rebels

      class Rebel < BaseSection
        purpose_element :name
      end
      purpose_sections :rebel, 'tbody tr[role="row"]'

    end
  end
end
