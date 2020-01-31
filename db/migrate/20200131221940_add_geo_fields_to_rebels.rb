class AddGeoFieldsToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :lat, :decimal, precision: 10, scale: 6
    add_column :rebels, :lon, :decimal, precision: 10, scale: 6
  end
end
