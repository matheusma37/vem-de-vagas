class Company < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'

  has_one_attached :cover
  has_one_attached :logo

  validates :email_domain, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9]+\.[a-z]+(\.[a-z]+)?\z/i }
  validates :cnpj, uniqueness: true, if: :cnpj_filled?
  validates :site, uniqueness: true, if: :site_filled?

  private

  def cnpj_filled?
    !cnpj.nil?
  end

  def site_filled?
    !site.nil?
  end
end
