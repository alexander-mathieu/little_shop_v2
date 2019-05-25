FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "item_name #{n}"
    end

    sequence :description do |n|
      "description #{n}"
    end

    sequence :image do |n|
      "item#{n}.jpg"
    end
  end
end
