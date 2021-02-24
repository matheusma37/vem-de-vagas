class User < ApplicationRecord
  after_create :add_profile_type

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_one :employee_profile

  validates :username, :full_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, format: { with: /([0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}|[0-9]{11})/ }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A[a-z0-9.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?\z/i }

  private

  def add_profile_type
    company = Company.find_by(email_domain: email.split('@').last)
    EmployeeProfile.create(user: self, company: company)
  end
end
