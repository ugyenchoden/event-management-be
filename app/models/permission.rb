class Permission < ApplicationRecord
  belongs_to :accessor, polymorphic: true
end
