class AddCodeToWorkingGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :working_groups, :code, :string
  end
end
