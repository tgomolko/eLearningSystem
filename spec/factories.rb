FactoryBot.define do
  factory :user do
    name { "Joe" }
    email { "joe@elearning.com" }
    password { "blah2322" }
  end

  factory :organization do
    company_name { "iTechArt"}
    user_id { 1 }
  end

  factory :course do
    title { "Ruby"}
    access_state { "Public" }
    user { User.first || association(:user) }
  end
end
