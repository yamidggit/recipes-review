FactoryGirl.define do

  factory :user do
    sequence(:email){ |e| "email#{e}@example.com"}
    password "password"
    password_confirmation "password"
  end

end
