FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    description { 'Factoryで作ったタスク1です' }
    expired_at { Time.new(2020, 1, 10, 17, 0) }
  end

  factory :task2, class: Task do
    name { 'タスク2' }
    description { 'Factoryで作ったタスク2です' }
    created_at { Time.new(2019, 12, 7, 10, 0) }
    expired_at { Time.new(2019, 12, 10, 22, 30) }
  end

  factory :task3, class: Task do
    name { 'テスト1' }
    description { 'Factoryで作ったタスク3です' }
    created_at { Time.new(2019, 12, 5, 10, 0) }
    expired_at { Time.new(2019, 12, 7, 17, 0) }
    status { 2 }
  end
end
