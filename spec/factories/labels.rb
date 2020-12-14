FactoryBot.define do
  factory :label do
    name { "FirstLabel" }
  end

  factory :second_label, class: Label do
    name { "SecondLabel" }
  end

  factory :third_label, class: Label do
    name { "ThirdLabel" }
  end

end
