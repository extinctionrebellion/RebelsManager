class AddLanguageToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :language, :string
  end
end
