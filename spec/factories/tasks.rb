FactoryBot.define do
  factory :task1, class: Task do
    name { '植栽1' }
    description { 'Factoryで作ったタスク1です' }
    created_at { Time.new(2019, 12, 5, 10, 0) }
    expired_at { Time.new(2019, 12, 14, 17, 0) }
    status { 2 } # 完了
    priority { 2 } # 高
  end

  factory :task2, class: Task do
    name { '植栽2' }
    description { 'Factoryで作ったタスク2です' }
    created_at { Time.new(2019, 12, 6, 10, 0) }
    expired_at { Time.new(2019, 12, 24, 22, 30) }
    status { 1 } # 着手中
    priority { 1 } # 中
  end

  factory :task3, class: Task do
    name { '伐採1' }
    description { 'Factoryで作ったタスク3です' }
    created_at { Time.new(2019, 12, 7, 10, 0) }
    expired_at { Time.new(2019, 12, 31, 17, 0) }
    status { 0 } # 未着手
    priority { 0 } # 低
  end
end
