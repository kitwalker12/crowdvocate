# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    url "<iframe width=\"420\" height=\"315\" src=\"//www.youtube.com/embed/sXX-XgmMd7E\" frameborder=\"0\" allowfullscreen></iframe>"
    user
    project
  end
end
