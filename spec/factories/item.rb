FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "item_name #{n}"
    end

    sequence :description do |n|
      "description #{n}"
    end

    image {"https://tradersofafrica.com/img/no-product-photo.jpg"}

    active {true}

    inventory {1}
    
    price {10.00}
  end
end
