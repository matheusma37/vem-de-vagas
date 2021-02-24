class Company < ApplicationRecord
  validates :email_domain, uniqueness: true
end
