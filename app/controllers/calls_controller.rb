class CallsController < BaseController
  def index
    @rebels = Rebel
      .where(local_group: current_user.local_group)
      .where.not(phone: nil)
      .where.not(dont_call: true)
      .order(:phone_campaign_status)
  end

  private

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: "calls",
      user: current_user
    )
  end
end
