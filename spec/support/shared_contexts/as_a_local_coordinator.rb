RSpec.shared_context 'as a local coordinator' do

  let!(:current_local_group) { create(:local_group) }
  let!(:current_user) { create(:user, local_group: current_local_group) }

  before do
    login_as(current_user, scope: :user)
  end

end
