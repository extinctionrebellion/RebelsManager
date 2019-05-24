class AddColorToWorkingGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :working_groups, :color, :string
  end
end
