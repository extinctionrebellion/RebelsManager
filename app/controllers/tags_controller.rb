class TagsController < BaseController
  def index
    respond_to do |format|
      format.html do
        @tags_count = ActsAsTaggableOn::Tag.all.count
      end
      format.json do
        render json: TagDatatable.new(
          params,
          view_context: view_context
        )
      end
    end
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @tagged_rebels_count = Rebel.tagged_with(@tag.name).count
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
      active_primary: 'tags',
      user: current_user
    )
  end
end
