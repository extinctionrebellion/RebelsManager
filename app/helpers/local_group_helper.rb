module LocalGroupHelper
  def filtered_link(local_group)
    if current_user.admin?
      link_to(local_group.name, local_group_path(local_group.id))
    else
      local_group.name
    end
  end
end
