class AddEmailCiphertextToRebels < ActiveRecord::Migration[5.2]
  def change
    # encrypted data
    add_column :rebels, :email_ciphertext, :string

    # blind index
    add_column :rebels, :email_bidx, :string
    add_index :rebels, :email_bidx, unique: true
  end
end
