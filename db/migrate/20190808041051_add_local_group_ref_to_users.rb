class AddLocalGroupRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :local_group, null: true, foreign_key: true
  end
end
