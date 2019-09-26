class AddColumnToLocalGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :local_groups, :welcome_email_body, :text
  end
end
