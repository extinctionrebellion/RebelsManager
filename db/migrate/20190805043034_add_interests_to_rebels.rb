class AddInterestsToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :interests, :string
  end
end
