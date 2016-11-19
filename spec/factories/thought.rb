FactoryGirl.define do
  factory :thought do
    user

    trait :public do
      is_public true
    end
    trait :private do
      is_public false
    end
  end
end
