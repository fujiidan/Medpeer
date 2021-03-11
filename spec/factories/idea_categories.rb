FactoryBot.define do
  factory :idea_category do
    name {Faker::Lorem.words}
    body {Faker::Lorem.sentence}
  end
end
