FactoryBot.define do
  factory :group do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    phone_number          { Faker::Number.number(digits: 10) }
    base_address          { Gimei.address.kanji }
    url                   { Faker::Internet.url }
    group_category        { Faker::Number.between(from: 0, to: 3) }
    password              { Faker::Internet.password(min_length: 6, mix_case: true) }
    password_confirmation { password }
  end
end
