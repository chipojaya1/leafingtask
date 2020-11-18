FactoryBot.define do
  factory :task do
    title { 'title test' }
    content { 'content test 1' }
  end
  factory :second_task, class: Task do
    title { 'title test 2' }
    content { 'content test 2' }
  end
  factory :third_task, class: Task do
    title { 'title test 3' }
    content { 'content test 3' }
  end
end
