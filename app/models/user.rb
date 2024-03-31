class User < ApplicationRecord
  validates :country_code, presence: true
  validates :phone_number, :city, :state, :country, presence: true

  validates :phone_number, length: { is: 10 }, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }

  # Combine country code and phone number
  def full_phone_number
    "#{country_code}#{phone_number}"
  end
end
