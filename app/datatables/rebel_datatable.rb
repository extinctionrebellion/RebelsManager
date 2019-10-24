class RebelDatatable < ApplicationDatatable
  # extend Forwardable

  # def_delegator :@view, :l
  # def_delegator :@view, :link_to
  # def_delegator :@view, :check_box_tag
  # def_delegator :@view, :content_tag
  # def_delegator :@view, :rebel_path
  # def_delegator :@view, :raw
  # def_delegator :@view, :truncate

  def initialize(params, opts = {})
  #   @user = opts[:user]
    @view = opts[:view_context]
  #   # @options = opts
    super
  end

  def user
    @user ||= options[:user]
  end

  def view_columns
    @view_columns ||= {
      name:               { source: "Rebel.name" },
      email:              { source: "Rebel.email" }
      # name:               { source: "Rebel.name", cond: whitespaced_start_with },
      # email:              { source: "Rebel.email", cond: :start_with }
      # local_group:        { source: "Local_group.name", cond: :starts_with },
      # created_at:         { source: "Rebel.created_at" },
      # status:             { source: "Rebel.status", cond: :starts_with },
      # postcode:           { source: "Rebel.postcode" },
      # working_groups:     { source: "WorkingGroup.name", cond: :starts_with },
      # tags:               { source: "Tag.name", cond: :starts_with },
      # number_of_arrests:  { source: "Rebel.number_of_arrests", cond: :eq }
    }
  end

  private

  def data
    records.map do |rebel|
      {
        # id:                 "",
        # object_id:          rebel.id,
        name:               rebel.name, #cell_name(rebel),
        email:              rebel.email, #cell_email(rebel),
        # local_group:        cell_local_group(rebel),
        # created_at:         cell_created_at(rebel),
        # status:             rebel.status.presence || "-",
        # postcode:           rebel.postcode.presence || "-",
        # working_groups:     cell_working_groups(rebel),
        # tags:               cell_tags(rebel),
        # number_of_arrests:  cell_number_of_arrests(rebel),
        DT_RowId:           "selected-id-#{rebel.email}"
      }
    end
  end

  def cell_created_at(rebel)
    l(rebel.created_at.to_date)
  end

  def cell_email(rebel)
    cell_value = "#{rebel.email.split("@")&.first}@&hellip;"
    raw(cell_value)
  end

  def cell_local_group(rebel)
    rebel.local_group.presence || "-"
  end

  def cell_name(rebel)
    cell_value = link_to((rebel.name.presence || "-"), rebel_path(rebel))
    # if rebel.notes.present?
    #   cell_value << " #{content_tag(:small, 🗒, title: rebel.notes, 'data-tooltip': true)}"
    # end
    raw(cell_value)
  end

  def cell_number_of_arrests(rebel)
    "number_of_arrests:#{rebel.number_of_arrests.presence || 0}"
  end

  def cell_tags(rebel)
    rebel.tag_list
  end

  def cell_working_groups(rebel)
    cell_value = ""
    rebel.working_groups.each do |working_group|
      cell_value << content_tag(:span, working_group.name, class: "primary label")
    end
    raw(cell_value)
  end

  def get_raw_records
    if user.local_group
      Rebel
        .where(local_group: user.local_group)
        .order(created_at: :desc)
        .includes(:local_group, :working_groups)
        .references(:local_group)
    else
      Rebel.all
        # .order(created_at: :desc)
        # .includes(:local_group, :working_groups)
        # .references(:local_group)
    end
  end
end
