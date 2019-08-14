class RebelsController < ApplicationController
  skip_before_action :verify_authenticity_token, on: [:create]

  def new
    @rebel = Rebel.new
  end

  def create
    service = Rebels::CreateService.new
    if service.run(rebel_params)
      redirect_to service.redirect_url
    else
      @rebel = service.rebel
      flash.now[:error] = service.error_message unless !@rebel.valid?
      render :new
    end
  end

  private

  def rebel_params
    params.require(:rebel).permit(
      :consent,
      :name,
      :email,
      :language,
      :local_group_id,
      :notes,
      :phone,
      :postcode,
      :redirect
    )
  end
end
