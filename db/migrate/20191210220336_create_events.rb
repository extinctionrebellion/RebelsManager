class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :starts_at
      t.string :ends_at
      t.string :facebook_url
      t.references :local_group

      t.timestamps
    end
  end
end
