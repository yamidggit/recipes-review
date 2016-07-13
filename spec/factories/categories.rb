FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Tag #{n}" }
  end
end
