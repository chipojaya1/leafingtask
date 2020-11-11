FactoryBot.define do
  factory :task_one do
    title { 'title test' }
    content { 'content test 1' }
  end
  factory :task_two, class: Task do
    title { 'title test 2' }
    content { 'content test 2' }
  end
  factory :task_three, class: Task do
    title { 'title test 3' }
    content { 'content test 3' }
  end
end
