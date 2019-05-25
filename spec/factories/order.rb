FactoryBot.define do
  factory :order do
    sequence :status do |n|
      "pending"
    end
  end
  factory :pending, parent: :order do
    sequence :status do |n|
      "pending"
    end
  end
  factory :packaged, parent: :order do
    sequence :status do |n|
      "packaged"
    end
  end
  factory :shipped, parent: :order do
    sequence :status do |n|
      "shipped"
    end
  end
  factory :cancelled, parent: :order do
    sequence :status do |n|
      "cancelled"
    end
  end
end
