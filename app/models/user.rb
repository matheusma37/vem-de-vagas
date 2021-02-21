class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :full_name, :cpf, presence: true
  validates :cpf, uniqueness: true, format: { with: /([0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}|[0-9]{11})/ }
end
