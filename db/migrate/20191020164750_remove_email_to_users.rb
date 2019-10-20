class RemoveEmailToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :email
  end
end
