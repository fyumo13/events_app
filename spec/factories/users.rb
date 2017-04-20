FactoryGirl.define do
  factory :user do
    first_name "Fredrik"
    last_name "Yumo"
    email "email@gmail.com"
    city "Seattle"
    state "WA"
    password "password"
    password_confirmation "password"
  end
end
