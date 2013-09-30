# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "Sample Pitch"
    description "Description for sample pitch"
    body "Sample Pitch Body"
    slug "sample-pitch"
    goal 1000
    deadline 15.days.from_now
    published false
    published_at Time.now
    user
  end
end
