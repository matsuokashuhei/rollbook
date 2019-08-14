# frozen_string_literal: true

class UserAuthentication < ApplicationRecord
  # relations
  belongs_to :user

  # enums
  enum provider: { cognito: 0 }

  # validations
  validates :provider, presence: true, inclusion: { in: providers.keys }
  validates :sub, presence: true, uniqueness: { scope: [:provider] }
end
