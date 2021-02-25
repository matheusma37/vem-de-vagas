class Company < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'

  validates :email_domain, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9]+\.[a-z]+(\.[a-z]+)?\z/i }
  validates :cnpj, uniqueness: true
  validates :site, uniqueness: true
end
