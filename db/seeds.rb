(1..100).each do |i|
  status = rand(3)
  Task.create!(
    name: "タスク#{i}",
    description: "タスクの登録テスト#{i}です",
    expired_at: Time.now + 60 * 60 * 24 * i,
    status: status
  )
end
