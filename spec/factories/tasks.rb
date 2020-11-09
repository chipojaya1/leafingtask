FactoryBot.define do
  factory :task do
    title { 'Factory default title 1' }
    content { 'Factory default content 1' }
    duedate { DateTime.now}
  end

  factory :second_task, class: Task do
    title { 'Factory default title 2' }
    content { 'Factory default content ２' }
    duedate { DateTime.tomorrow }
    status {'pending'}
    priority {'middle'}
  end

  factory :third_task, class: Task do
    title { 'Factory default title ３' }
    content { 'Factory default content ３' }
    duedate { DateTime.now.since(4.days) }
    status { 'current' }
    priority { 'high' }
  end
  
end
