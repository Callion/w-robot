# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password '12345678'
    password_confirmation '12345678'
  end

  factory :automation do
    name 'MyString'
    active false
    browser_type 'Firefox'
    user
  end

  factory :procedure do
    automation
    position 1
    script "goto 'google.cz'"
  end
end
