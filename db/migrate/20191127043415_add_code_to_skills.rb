class AddCodeToSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :skills, :code, :string
  end
end
