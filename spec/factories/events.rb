# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    body "Sample Event"
    user
    project
  end
end
