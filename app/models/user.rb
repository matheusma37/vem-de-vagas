# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  about_me               :text
#  cpf                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  after_create :add_profile_type

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_one :employee_profile
  has_one :company, through: :employee_profile
  has_one :candidate_profile

  accepts_nested_attributes_for :employee_profile
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

  def applied?(job_opportunity)
    candidate_profile.applied?(job_opportunity)
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
