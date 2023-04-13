# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
