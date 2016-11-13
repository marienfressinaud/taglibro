FactoryGirl.define do
  factory :user do
    email 'john@doe.com'
    password 'secret'

    after(:build) do |user, evaluator|
      user.password_confirmation = evaluator.password
    end

    factory :user_activated do
      after(:create) do |user|
        user.activate!
      end
    end
  end
end
