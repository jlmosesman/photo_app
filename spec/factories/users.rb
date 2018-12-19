FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Bob#{n}" }
    sequence(:last_name) { |n| "Smith#{n}" }
    sequence(:email) { |n| "user#{n}@email.com" }

    password { "password" }
    password_confirmation { "password" }
  end
end
