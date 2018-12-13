FactoryGirl.define do

  factory :comment do
    sequence(:commenter) { |n| "Joe Bob #{n}" }
    sequence(:body) { |n| "Such a great article #{n}." }
    article
  end
end
