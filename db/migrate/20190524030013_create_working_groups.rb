class CreateWorkingGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :working_groups do |t|
      t.references :local_group, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
