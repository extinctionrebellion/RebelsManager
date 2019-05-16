class RebelsController < ApplicationController
  def new
    @rebel = Rebel.new
  end

  def create
    @rebel = Rebel.new(rebel_params)
    if @rebel.save
      redirect_to new_rebel_path(
        notice: "Merci, nous te recontactons prochainement!"
      )
    else
      render :new
    end
  end

  private

  def rebel_params
    params.require(:rebel).permit(
      :name,
      :email,
      :phone,
      :notes
    )
  end
end
