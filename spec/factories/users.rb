# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "todo@mcorp.io"
    password "secret"
  end
end
