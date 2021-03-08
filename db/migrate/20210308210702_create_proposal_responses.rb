class CreateProposalResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :proposal_responses do |t|
      t.date :start_date, null: false
      t.float :salary_proposal, null: false
      t.text :message, null: false
      t.references :job_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
