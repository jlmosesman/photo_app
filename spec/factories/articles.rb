FactoryGirl.define do

  factory :article do
    title 'My Article'
    text 'This is my article text.'

    trait :with_comments do
      after(:create) do |article, evaluator|
        create_list(:comment, 3, article: article)
      end
    end

    factory :article_with_comments, traits: [:with_comments]
  end

  factory :invalid_article, parent: :article do
    title nil
    text nil
  end
end
