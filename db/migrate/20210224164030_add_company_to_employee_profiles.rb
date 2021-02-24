class AddCompanyToEmployeeProfiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :employee_profiles, :company, null: false, foreign_key: true
  end
end
