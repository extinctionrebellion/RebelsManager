class AddTagsToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :tags, :text
  end
end
