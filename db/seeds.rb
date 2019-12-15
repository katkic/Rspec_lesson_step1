User.create!(
  name: '山田太郎',
  email: 'yamada@example.com',
  password: 'password!',
  password_confirmation: 'password!',
  admin: true
)

15.times do
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

(1..300).each do |i|
  Task.create!(
    name: "タスク#{i}",
    description: "タスクの登録テスト#{i}です",
    created_at: Time.current,
    updated_at: Time.current,
    expired_at: Time.current.advance(days: i + 10),
    status: rand(3),
    priority: rand(3),
    user_id: rand(16) + 1
  )
end
