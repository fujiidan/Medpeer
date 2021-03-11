FactoryBot.define do
  factory :idea_category do
    name {Faker::Lorem.word}
    body {Faker::Lorem.sentence}
  end
end
