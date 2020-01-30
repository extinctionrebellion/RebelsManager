class RebelDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :l
  def_delegator :@view, :link_to
  def_delegator :@view, :content_tag
  def_delegator :@view, :rebel_path
  def_delegator :@view, :raw

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def user
    @user ||= options[:user]
  end

  def view_columns
    @view_columns ||= {
      name:               { source: "Rebel.name", cond: whitespaced_start_with },
      local_group:        { source: "LocalGroup.name", cond: :start_with },
      created_at:         { source: "Rebel.created_at" },
      active:             { source: "Rebel.active" },
      status:             { source: "Rebel.status", cond: :start_with },
      postcode:           { source: "Rebel.postcode", cond: whitespaced_start_with },
      working_groups:     { source: "WorkingGroup.name", cond: :start_with },
      tags:               { source: "ActsAsTaggableOn::Tag.name", cond: whitespaced_start_with },
      notes:              { source: "Rebel.notes", cond: whitespaced_start_with }
    }
  end

  private

  def data
    records.map do |rebel|
      {
        name:               cell_name(rebel),
        email:              cell_email(rebel),
        local_group:        cell_local_group(rebel),
        created_at:         cell_created_at(rebel),
        active:             (rebel.active? ? "rebel" : "supporter"),
        status:             rebel.status.presence || "-",
        postcode:           rebel.postcode.presence || "-",
        working_groups:     cell_working_groups(rebel),
        tags:               cell_tags(rebel),
        notes:              rebel.notes.presence || "-",
        DT_RowId:           "selected-id-#{rebel.email}"
      }
    end
  end

  def cell_created_at(rebel)
    l(rebel.created_at.to_date, format: :shorter_with_year)
  end

  def cell_email(rebel)
    cell_value = "#{rebel.email.split("@")&.first}@&hellip;"
    raw(cell_value)
  end

  def cell_local_group(rebel)
    rebel.local_group&.name&.presence || "-"
  end

  def cell_name(rebel)
    cell_value = link_to((rebel.name.presence || "-"), rebel_path(rebel))
    if rebel.notes.present?
      cell_value << " "
      cell_value << content_tag(
        :small,
        "🗒",
        title: rebel.notes,
        'data-tooltip': true
      )
    end
    raw(cell_value)
  end

  def cell_tags(rebel)
    rebel.tag_list
  end

  def cell_working_groups(rebel)
    cell_value = ""
    rebel.working_groups.each do |working_group|
      cell_value << content_tag(
        :span,
        working_group.name.split.map(&:first).join,
        class: "primary label",
        style: "background-color: #{working_group.color}",
        title: working_group.name,
        'data-tooltip': true
      )
    end
    raw(cell_value)
  end

  def get_raw_records
    if user.local_group
      Rebel
        .where(local_group: user.local_group)
        .includes(:local_group, :tags, :working_groups)
        .references(:local_group)
    else
      Rebel.all
        .includes(:local_group, :tags, :working_groups)
        .references(:local_group)
    end
  end
end
