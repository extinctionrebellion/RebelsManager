class RebelDatatable < ApplicationDatatable
  def_delegator :@view, :link_to
  def_delegator :@view, :check_box_tag
  def_delegator :@view, :content_tag
  def_delegator :@view, :rebel_path
  def_delegator :@view, :raw
  def_delegator :@view, :truncate

  def initialize(params, opts = {})
    @view = opts[:view_context]
    @options = opts
    super
  end

  def view_columns
    @view_columns ||= {
      name:           { source: "Rebel.name", cond: whitespaced_start_with },
      email:          { source: "Rebel.email", cond: :start_with },
      local_group:    { source: "Local_group.name", cond: :starts_with },
      created_at:     { source: "Rebel.created_at" },
      status:         { source: "Rebel.status", cond: :starts_with },
      postcode:       { source: "Rebel.postcode" },
      working_groups: { source: "WorkingGroup.name", cond: :starts_with },
      tags:           { source: "Tag.name", cond: :starts_with }
    }
  end

  private

  def data
    records.map do |customer|
      {
        id:           "",
        object_id:    rebel.id,
        name:         cell_name(rebel),
        email:        cell_email(rebel),
        phone:        customer.phone,
        city:         customer.city,
        has_login:    cell_has_login(customer),
        custom_id:    customer.custom_id,
        add_to_class: cell_add_to_class(customer),
        self_checkin: cell_self_checkin(customer),
        reservation_link: cell_reservation_link(customer),
        flag:         customer.flags&.first&.status,
        DT_RowId:     "selected-id-#{customer.id}"
      }
    end
  end

  def cell_email(customer)
    cell_value = "#{rebel.email.split("@")&.first}@&hellip;"
    raw(cell_value)
  end

  def cell_name(rebel)
    cell_value = link_to((rebel.name.presence || "-"), rebel_path(rebel))
    if rebel.notes.present?
      cell_value << " #{content_tag(:small, 🗒, title: rebel.notes, 'data-tooltip': true)}"
    end
    raw(cell_value)
  end

  def cell_has_login(customer)
    if access.member_accounts? and customer.account_id.present?
      content_tag(:i, nil, class: "fa fa-check", style: "color: #6BB03F")
    end
  end
end
