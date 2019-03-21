Fabricator(:user) do
  name     { Faker::Internet.user_name }
  email    { Faker::Internet.email}
  password {Faker::Internet.password}
  role     { (0..3).to_a.sample }
  confirmed_at { Time.zone.now }
end