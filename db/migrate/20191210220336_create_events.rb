class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :start_at
      t.string :end_at
      t.string :facebook_url
      t.references :local_group

      t.timestamps
    end
  end
end
