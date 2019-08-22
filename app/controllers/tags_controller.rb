class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def edit
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def update
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path,
                  notice: "The <strong>#{@tag.name}</strong> tag has been updated."
    else
      render :edit
    end
  end

  private

  def tag_params
    params.require(:acts_as_taggable_on_tag).permit(
      :name
    )
  end

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: 'tags'
    )
  end
end
