class ChangeCnpjInCompanies < ActiveRecord::Migration[6.1]
  def change
    change_column_null :companies, :cnpj, true
    change_column_default :companies, :cnpj, from: '', to: nil
  end
end
