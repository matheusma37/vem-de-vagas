class CreateRefusalResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :refusal_responses do |t|
      t.integer :refuser, default: 3
      t.text :reason
      t.references :job_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
