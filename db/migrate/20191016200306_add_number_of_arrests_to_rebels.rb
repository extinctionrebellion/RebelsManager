class AddNumberOfArrestsToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :number_of_arrests, :integer
  end
end
