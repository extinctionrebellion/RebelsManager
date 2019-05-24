class AddEmailToLocalGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :local_groups, :email, :string
  end
end
