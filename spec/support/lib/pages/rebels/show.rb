module Pages
  module Rebels
    class Show < BasePage
      set_url '/rebels/{id}'

      purpose_link :edit
    end
  end
end
