FactoryBot.define do
  factory :user do
    username { 'test' }
    password { 'test' }
    password_confirmation { 'test' }
  end

  factory :todo do
    user { User.last }
    title { 'test_todo' }
  end
end