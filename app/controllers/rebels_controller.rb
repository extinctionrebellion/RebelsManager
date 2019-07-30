class RebelsController < ApplicationController
  skip_before_action :verify_authenticity_token, on: [:create]

  def new
    @rebel = Rebel.new
  end

  def create
    @rebel = Rebel.new(rebel_params)
    if @rebel.save
      redirect_to "https://www.extinctionrebellion.be/thank-you.html"
    else
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
      :postcode
    )
  end
end
