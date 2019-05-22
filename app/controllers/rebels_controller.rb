class RebelsController < ApplicationController
  def new
    @rebel = Rebel.new
  end

  def create
    @rebel = Rebel.new(rebel_params)
    @rebel.local_group = LocalGroup.where(name: 'Namur')&.take
    if @rebel.save
      redirect_to new_rebel_path,
                  notice: "Merci et bienvenue! Nous prendrons prochainement contact avec toi."
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
