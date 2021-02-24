class User < ApplicationRecord
  after_create :add_profile_type

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_one :employee_profile

  validates :username, :full_name, :cpf, presence: true
  validates :cpf, uniqueness: true, format: { with: /([0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}|[0-9]{11})/ }

  private

  def add_profile_type
    EmployeeProfile.create(user: self)
  end
end
