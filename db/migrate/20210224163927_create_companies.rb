class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :email_domain, unique: true, null: false

      t.timestamps
    end
  end
end
