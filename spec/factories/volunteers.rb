FactoryBot.define do
  factory :volunteer do
    title              { Faker::Number.within(range: 0..40) }
    place              { Gimei.address.kanji }
    details            { Faker::Number.within(range: 0..1000) }
    schedule           { Faker::Date.between(from: 3.days.from_now, to: 7.days.from_now) }
    start_time         { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day) }
    end_time           { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :night) }
    expenses           { Faker::Number.within(range: 0..40) }
    conditions         { Faker::Number.within(range: 0..40) }
    application_people { Faker::Number.non_zero_digit }
    deadline           { Faker::Date.between(from: 1.days.from_now, to: 2.days.from_now) }
    association :postable, factory: :user
  end
end
