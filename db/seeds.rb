(1..100).each do |i|
  Task.create!(
    name: "タスク#{i}",
    description: "タスクの登録テスト#{i}です",
    created_at: Time.now + 60 * 60 * 24 * i,
    updated_at: Time.now + 60 * 60 * 24 * i,
    expired_at: Time.now + 60 * 60 * 24 * (i + 7),
    status: rand(3),
    priority: rand(3)
  )
end
