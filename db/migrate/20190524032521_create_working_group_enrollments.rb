class CreateWorkingGroupEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :working_group_enrollments do |t|
      t.references :rebel, null: false, foreign_key: true
      t.references :working_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
