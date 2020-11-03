class TagDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :l
  def_delegator :@view, :link_to
  def_delegator :@view, :content_tag
  def_delegator :@view, :tag_path
  def_delegator :@view, :raw

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      name:               { source: "ActsAsTaggableOn::Tag.name", cond: whitespaced_start_with },
      count:              { source: "ActsAsTaggableOn::Tag.taggings_count" }
    }
  end

  private

  def data
    records.map do |tag|
      {
        name:               cell_name(tag),
        count:              cell_count(tag)
      }
    end
  end

  def cell_name(tag)
    cell_value = link_to(tag.name, tag_path(tag))
    raw(cell_value)
  end

  def cell_count(tag)
    cell_value = link_to(tag.taggings_count, tag_path(tag))
    raw(cell_value)
  end

  def get_raw_records
    ActsAsTaggableOn::Tag.all
  end
end
