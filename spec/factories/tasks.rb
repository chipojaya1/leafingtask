FactoryBot.define do
  factory :task do
    title { 'test1' }
    content { 'content test 1' }
    duedate { '2020-11-30 11:00:00' }
    association :user
  end
  factory :second_task, class: Task do
    title { 'test2' }
    content { 'content test 2' }
    duedate{ '2020-12-30 00:00:00' }
    association :user
  end
  factory :third_task, class: Task do
    title { 'sample3' }
    content { 'sample 3' }
    duedate{ '2020-12-18 17:00:00' }
    association :user
  end
end
