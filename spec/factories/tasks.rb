FactoryBot.define do
  factory :task do
    title { 'title test' }
    content { 'content test' }
    deadline { '2020-09-03 17:00:00' }
    status { 'status' }
    priority { '0' }
  end
  factory :second_task, class: Task do
    title { 'title test 2' }
    description { 'content test 2' }
    deadline { '2020-09-11 00:00:00' }
    status { 'pending' }
    priority { '0' }
  end
end
