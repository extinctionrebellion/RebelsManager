require 'rails_helper'

RSpec.describe Events::CreateService, '#run' do
  describe 'When creation works' do
    it 'creates the event' do

      params = ActionController::Parameters.new({
        event: {
          name: 'Standup',
          description: 'A standup about ecology',
          starts_at: '19/12/2020',
          ends_at: '21/12/2020',
          facebook_url: 'https://facebook.com',
        }
      })

      service = Events::CreateService.new
      service.run(params)

      expect(Event.count).to eq(1)
    end
  end

  describe 'When description is missing' do
    it 'doesn\'t create the event' do
      params = ActionController::Parameters.new({
        event: {
          name: 'Standup',
          starts_at: '19/12/2020',
          ends_at: '21/12/2020',
          facebook_url: 'https://facebook.com',
        }
      })

      service = Events::CreateService.new
      service.run(params)

      expect(Event.count).to eq(0)
    end
  end
end
