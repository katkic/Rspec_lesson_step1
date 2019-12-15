FactoryBot.define do
  factory :task1, class: Task do
    name { '植栽1' }
    description { 'Factoryで作ったタスク1です' }
    created_at { Time.current.advance(days: -3) }
    expired_at { Time.current.advance(days: 5) }
    status { 2 } # 完了
    priority { 2 } # 高
    user
  end

  factory :task2, class: Task do
    name { '植栽2' }
    description { 'Factoryで作ったタスク2です' }
    created_at { Time.current.advance(days: -2) }
    expired_at { Time.current.advance(days: 10) }
    status { 1 } # 着手中
    priority { 1 } # 中
    user
  end

  factory :task3, class: Task do
    name { '伐採1' }
    description { 'Factoryで作ったタスク3です' }
    created_at { Time.current.advance(days: -1) }
    expired_at { Time.current.advance(days: 15) }
    status { 0 } # 未着手
    priority { 0 } # 低
    user
  end
end
