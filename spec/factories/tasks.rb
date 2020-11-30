FactoryBot.define do
  factory :task do
    title { 'title test' }
    content { 'content test 1' }
  end
  factory :second_task, class: Task do
    title { 'title test 2' }
    content { 'content test 2' }
  end
end
