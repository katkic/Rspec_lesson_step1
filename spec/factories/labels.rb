FactoryBot.define do
  factory :label1, class: Label do
    name { 'test_label1' }
    user
  end

  factory :label2, class: Label do
    name { 'test_label2' }
    user
  end

  factory :label3, class: Label do
    name { 'test_label3' }
    user
  end
end
