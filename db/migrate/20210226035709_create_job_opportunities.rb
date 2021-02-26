class CreateJobOpportunities < ActiveRecord::Migration[6.1]
  def change
    create_table :job_opportunities do |t|
      t.string :title, null: false
      t.text :description
      t.float :max_salary, null: false, default: 0
      t.float :min_salary, null: false, default: 0
      t.integer :professional_level, null: false, default: 3
      t.date :application_deadline
      t.integer :total_job_opportunities, null: false
      t.integer :status, null: false, default: 3
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
