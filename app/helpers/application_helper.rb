module ApplicationHelper
  def params_plus(additional_params)
    params.to_unsafe_h.merge(additional_params)
  end

  def delete_link(resource)
    return unless resource.destroyable_by?(current_user)
    link_to "Delete",
            send("#{resource.class.name.downcase}_path", resource),
            method: :delete,
            data: { confirm: 'Are you sure?' },
            class: 'secondary button'
  end
end
