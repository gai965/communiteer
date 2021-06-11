FactoryBot.define do
  factory :user do
    name              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true) }
    password_confirmation { password }
  end
end
