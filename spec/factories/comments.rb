FactoryGirl.define do
  factory :comment do
    content "This is my comment."
    user nil
    event nil
  end
end
