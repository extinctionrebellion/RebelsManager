module LocalGroupHelper
    def delete_link(local_group, current_user)
        if current_user.admin && local_group.destroyable?
            link_to("Delete", local_group_path(local_group), method: :delete, data: { confirm: 'Are you sure?' }, class: 'secondary button')
        end
    end
end
