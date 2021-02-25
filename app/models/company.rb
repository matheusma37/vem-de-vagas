class Company < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'

  validates :email_domain, uniqueness: { case_sensitive: false }
end
