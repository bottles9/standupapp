FactoryBot.define do
  factory :user do
    association :account, factory: :account, strategy: :build
    name { "Mystring" }
    email {Faker::Internet.email}
    password { "123test" }
    password_confirmation { "123test" }
  end
end
