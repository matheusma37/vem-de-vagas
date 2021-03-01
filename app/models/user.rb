class User < ApplicationRecord
  delegate :company, to: :employee_profile

  after_create :add_profile_type

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_one :employee_profile
  has_one :candidate_profile

  accepts_nested_attributes_for :candidate_profile

  validates :username, :full_name, :cpf, presence: true
  validates :cpf, uniqueness: { case_sensitive: false }
  validates :cpf, format: { with: /([0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}|[0-9]{11})/ }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A[\d\w+-.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?\z/i }

  def as_employee?
    !!employee_profile
  end

  def admin?
    employee_profile&.admin?
  end

  private

  def add_profile_type
    unless ApplicationController.helpers.personal_mail?(email)
      company = Company.find_by(email_domain: email.split('@').last)
      company ||= Company.create!(email_domain: email.split('@').last, admin: self)
      if company.admin == self
        EmployeeProfile.create(user: self, company: company, role: 'admin')
      else
        EmployeeProfile.create(user: self, company: company)
      end
    end
    CandidateProfile.create(user: self)
  end
end
