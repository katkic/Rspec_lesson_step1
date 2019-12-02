FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    description { 'Factoryで作ったタスク1です' }
    expired_at { Time.new(2020, 1, 10, 17, 0) }
  end

  factory :second_task, class: Task do
    name { 'タスク2' }
    description { 'Factoryで作ったタスク2です' }
    expired_at { Time.new(2019, 12, 10, 22, 30) }
  end
end
