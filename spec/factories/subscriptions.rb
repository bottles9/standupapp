FactoryBot.define do
  factory :subscription do
    account { nil }
    plan_id { "MyString" }
    stripe_customer_id { "MyString" }
    start { "2019-09-06 23:58:04" }
    status { "MyString" }
    stripe_subscription_id { "MyString" }
    stripe_token { "MyString" }
    card_last4 { "MyString" }
    card_expiration { "MyString" }
    card_type { "MyString" }
    stripe_status { "MyString" }
    idempotency_key { "MyString" }
  end
end
