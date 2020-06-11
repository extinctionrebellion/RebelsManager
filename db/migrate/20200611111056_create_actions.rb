class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.string :name
      t.string :mailtrain_list_id

      t.timestamps
    end
  end
end
