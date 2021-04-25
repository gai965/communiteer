FactoryBot.define do
  factory :join_volunteer do
    name          { Gimei.name.kanji }
    phone_number  { Faker::Number.number(digits: 10) }
    number        { Faker::Number.non_zero_digit }
    inquiry       { Faker::Number.within(range: 0..40) }
    association :joinable, factory: :user
    association :volunteer
  end
end
