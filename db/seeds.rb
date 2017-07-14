User.create(name: "DevUser01", email: "a@a.a", password: "111111")
User.create(name: "DevUser02", email: "b@b.b", password: "111111")

@users = []
100.times do |n|
  @users << User.create!(name: Faker::Name.name, email: "user-#{n}@fake.users", password: "password")
end

1000.times do |n|
  Post.create!(content: Faker::Simpsons.quote, user: @users.sample, created_at: Faker::Date.between(2.days.ago, Date.today))
end