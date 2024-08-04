User.create!(name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 2,
  activated: true,
  activated_at: Time.zone.now)

## Generate new users
(1..10).each do |i|
  name = Faker::Name.name
  email = "#{i}-#{Faker::Internet.email}"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 1,
    activated: true,
    activated_at: Time.zone.now)
end
