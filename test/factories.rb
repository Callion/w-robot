# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password '12345678'
    password_confirmation '12345678'
  end

  factory :automation do
    name 'MyAutomation'
    active false
    browser_type 'phantomjs'
    user
  end

  factory :procedure do
    automation
    position 1
    action :goto
    input 'localhost:3000'
  end
end
