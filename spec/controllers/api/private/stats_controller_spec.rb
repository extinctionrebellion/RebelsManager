require "rails_helper"

RSpec.describe Api::Private::StatsController, type: :controller do
  context 'when Authorization header is missing' do
    it 'responds with 401' do
      get :show

      expect(response.status).to eql 401
    end
  end

  context 'when Authorization header is wrong' do
    let(:wrong_auth) { Base64.encode64('fake_username:fake_password')}

    it 'responds with 401' do
      request.headers['Authorization'] = "Basic #{wrong_auth}"

      get :show

      expect(response.status).to eql 401
    end
  end

  context 'when Authorization header is correct' do
    let(:correct_auth) do
      Base64.encode64(
        "#{ENV.fetch('BASIC_AUTH_USERNAME')}:#{ENV.fetch('BASIC_AUTH_PASSWORD')}"
      )
    end

    it 'responds with 200' do
      request.headers['Authorization'] = "Basic #{correct_auth}"

      get :show

      expect(response.status).to eql 200
    end
  end
end
