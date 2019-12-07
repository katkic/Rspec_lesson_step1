(1..100).each do |i|
  Task.create!(
    name: "タスク#{i}",
    description: "タスクの登録テスト#{i}です",
    expired_at: Time.now + 60 * 60 * 24 * i,
    status: rand(3),
    priority: rand(3)
  )
end
