# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { :admin }

    Role.names.each_key do |name|
      trait name do
        name { name }
      end
    end
  end
end
