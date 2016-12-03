require 'rails_helper'

FactoryGirl.define do
  pw = RandomData.random_sentence
  # declaring the name of the factory ':user'
  factory :user do
    name RandomData.random_name
    # each User the factory builds will have a unique email address using sequence.
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
  end
end
