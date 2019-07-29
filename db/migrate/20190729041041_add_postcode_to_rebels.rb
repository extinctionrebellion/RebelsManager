class AddPostcodeToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :postcode, :string
  end
end
