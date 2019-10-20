class AddPhoneCiphertextToRebels < ActiveRecord::Migration[5.2]
  def change
    # encrypted data
    add_column :rebels, :phone_ciphertext, :string

    # blind index
    add_column :rebels, :phone_bidx, :string
    add_index :rebels, :phone_bidx, unique: true
  end
end
