FactoryBot.define do
  factory :team do
    name { "MyString" }
    account { nil }
    timezone { "MyString" }
    has_reminder { false }
    has_recap { false }
    hash_id { "MyString" }
    reminder_time { "2019-08-30 00:04:30" }
    recap_time { "2019-08-30 00:04:30" }
  end
end
