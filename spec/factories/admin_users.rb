FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password { '11111111' }
  end
end
