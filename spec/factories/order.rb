FactoryBot.define do
  factory :pending, class: Order do
    status {"pending"}
  end

  factory :packaged, class: Order do
    status {"packaged"}
  end

  factory :shipped, class: Order do
    status {"shipped"}
  end

  factory :cancelled, class: Order do
    status {"cancelled"}
  end
end
