require 'rails_helper'

RSpec.describe 'Create and update a rebel then search for it' do

  include_context 'as a local coordinator'

  scenario 'Nominal' do
    i_display_the_list_of_rebels
    i_create_a_new_rebel_with_initial_details
    i_update_the_newly_created_rebel
    i_search_the_new_rebel_according_to_the_initial_data
    the_new_rebel_is_not_in_the_search_result
    i_search_the_new_rebel_according_to_the_updated_data
    the_new_rebel_is_in_the_search_result
  end

  private

  let(:rebels_list_page) { Pages::Rebels::Index.new }
  let(:rebels_new_page) { Pages::Rebels::Form.new }
  let(:rebels_show_page) { Pages::Rebels::Show.new }
  let(:rebels_edit_page) { Pages::Rebels::Form.new }


  let(:rebel_initial_email) { FFaker::Internet.safe_email }
  let(:rebel_initial_name) { FFaker::Name.name }
  let(:rebel_initial_phone) { FFaker::PhoneNumber.phone_number }

  let(:rebel_updated_name) { "Another name" }

  def i_display_the_list_of_rebels
    rebels_list_page.load
  end

  def i_create_a_new_rebel_with_initial_details
    rebels_list_page.add_new_rebel

    rebels_new_page.set_email rebel_initial_email
    rebels_new_page.set_name rebel_initial_name
    rebels_new_page.set_phone rebel_initial_phone
    rebels_new_page.set_language "Français"

    rebels_new_page.save
  end

  def i_update_the_newly_created_rebel
    rebels_show_page.edit

    rebels_edit_page.set_name rebel_updated_name

    rebels_new_page.save
  end

  def i_search_the_new_rebel_according_to_the_initial_data
    rebels_list_page.load

    rebels_list_page.search_rebels(rebel_initial_name)
  end

  def the_new_rebel_is_not_in_the_search_result
    expect(rebels_list_page).to have_no_rebels
  end

  def i_search_the_new_rebel_according_to_the_updated_data
    rebels_list_page.load

    rebels_list_page.search_rebels(rebel_updated_name)
  end

  def the_new_rebel_is_in_the_search_result
    expect(rebels_list_page).to have_rebel_with(name: rebel_updated_name)
  end
end
