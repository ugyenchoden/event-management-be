class Role < ApplicationRecord
  has_many :permissions, as: :accessor, dependent: :destroy
  has_many :users, dependent: :restrict_with_error

  enum name: {
    admin: 'Admin',
    user: 'User'
  }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
