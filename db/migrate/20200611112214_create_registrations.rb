class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.references :action, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :language
      t.boolean :participated_previously

      t.timestamps
    end
  end
end
