class CreateRebelSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :rebel_skills do |t|
      t.references :rebel, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
