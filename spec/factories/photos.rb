FactoryBot.define do
    factory :photo do
  
      trait :with_title do
        title { "Jungle Book" } 
      end
    end
  end