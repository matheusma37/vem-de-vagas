class CreateCandidateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :candidate_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :biography
      t.string :cellphone_number

      t.timestamps
    end
  end
end
