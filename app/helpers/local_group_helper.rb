module LocalGroupHelper
  def delete_link(local_group)
    return unless local_group.destroyable_by?(current_user)
    link_to "Delete",
            local_group_path(local_group),
            method: :delete,
            data: { confirm: 'Are you sure?' },
            class: 'secondary button'
  end
end
