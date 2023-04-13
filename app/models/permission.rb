# frozen_string_literal: true

class Permission < ApplicationRecord
  belongs_to :accessor, polymorphic: true
end
