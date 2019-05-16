class CreateRebels < ActiveRecord::Migration[6.0]
  def change
    create_table :rebels do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :notes
      t.boolean :on_basecamp

      t.timestamps
    end
  end
end
