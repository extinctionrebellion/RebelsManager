class AddRegularVolunteerToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :regular_volunteer, :boolean, default: false
  end
end
