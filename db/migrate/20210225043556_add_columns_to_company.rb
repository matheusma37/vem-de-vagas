class AddColumnsToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :name, :string
    add_column :companies, :description, :text
    add_column :companies, :cnpj, :string, null: false, default: ''
    add_column :companies, :creation_date, :date
    add_column :companies, :address, :string
    add_column :companies, :site, :string
    add_reference :companies, :user, null: false, foreign_key: true
  end
end
