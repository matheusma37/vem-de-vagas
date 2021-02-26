class Company < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'

  has_one_attached :cover
  has_one_attached :logo

  has_many :job_opportunities
  has_many :employee_profiles
  has_many :employees, through: :employee_profiles, source: :user

  validates :email_domain, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9]+\.[a-z]+(\.[a-z]+)?\z/i }
  validates :name, :cnpj, :site, presence: true, on: :update
  validates :cnpj, uniqueness: true, if: :cnpj_filled?
  validates :site, uniqueness: true, if: :site_filled?

  def employee?(user)
    employees.any? { |employee| employee == user }
  end

  private

  def cnpj_filled?
    !cnpj.nil?
  end

  def site_filled?
    !site.nil?
  end
end
