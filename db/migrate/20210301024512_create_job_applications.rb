class CreateJobApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :job_applications do |t|
      t.references :candidate_profile, null: false, foreign_key: true
      t.references :job_opportunity, null: false, foreign_key: true
      t.integer :status, default: 3
      t.timestamps
    end
  end
end
