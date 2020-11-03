class CreateExports < ActiveRecord::Migration[6.0]
  def change
    create_table :exports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :export_type
      t.string :format
      t.string :filename
      t.string :status

      t.timestamps
    end
  end
end
