10.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = 'password!'
  password_confirmation = 'password!'

  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation
  )
end

(1..100).each do |i|
  Task.create!(
    name: "タスク#{i}",
    description: "タスクの登録テスト#{i}です",
    created_at: Time.now + 60 * 60 * 24 * i,
    updated_at: Time.now + 60 * 60 * 24 * i,
    expired_at: Time.now + 60 * 60 * 24 * (i + 7),
    status: rand(3),
    priority: rand(3),
    user_id: rand(10) + 1
  )
end

# User.create!(
#   name: '山田太郎',
#   email: 'yamada@example.com',
#   password: 'password!',
#   password_confirmation: 'password!'
# )
