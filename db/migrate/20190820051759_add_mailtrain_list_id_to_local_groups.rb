class AddMailtrainListIdToLocalGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :local_groups, :mailtrain_list_id, :string
  end
end
