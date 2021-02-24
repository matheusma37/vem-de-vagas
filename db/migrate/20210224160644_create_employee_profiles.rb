class CreateEmployeeProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_profiles do |t|
      t.string :employee_code
      t.string :role
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
