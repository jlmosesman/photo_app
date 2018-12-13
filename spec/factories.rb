FactoryGirl.define do

  factory :article do
    title 'My Article'
    text 'This is my article text.'
  end

  factory :invalid_article, parent: :article do
    title nil
    text nil
  end

  factory :comment do
    commenter 'Jim Bob'
    body 'What a great article you have.'
  end
end
