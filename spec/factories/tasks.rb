FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task_#{n}" }
    sequence(:description) { |n| "Factoryで作ったtask_#{n}です" }
  end
end
